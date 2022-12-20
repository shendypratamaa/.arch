###################### ZSH ##############################
export HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
export LESSHISTFILE="$XDG_DATA_HOME/less/lesshst"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTSIZE=10000
export SAVEHIST=10000

# AUTO_CD
setopt auto_cd
set -o ignoreeof

# COMPLETIONS
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
fpath=("$HOME/.config/zsh/plugins/zsh-completions/src" $fpath)
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -d "$HOME/.config/zsh/plugins/zsh-syntax-highlighting" ]]; then
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=124'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[global-alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=048'
    ZSH_HIGHLIGHT_STYLES[command]='fg=048'
    ZSH_HIGHLIGHT_STYLES[function]='fg=048'
    ZSH_HIGHLIGHT_STYLES[command]='fg=048'
fi

# basic
alias src='exec $SHELL'
alias reboot='sudo shutdown -r now'
alias shutdown="sudo poweroff"
alias ls='exa -s Extension --icons -h'
alias la='exa -s Extension --icons -h -a'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias ln='ln -v'
alias gs="git status"
alias gl="git log"
alias gm="git commit -m"
alias gp="git push origin"
alias btw="neofetch"
alias lg="lazygit"
alias vim="nvim"
alias vi="vim"
alias pacman="sudo pacman"
alias ufw="sudo ufw"
alias systemctl="sudo systemctl"
alias npml="npm list --location=global --depth=0"
alias ppath="echo $PATH | tr ':' '\n'"
alias lf="lfrun"

# repo check
alias gh="xdg-open \`git remote -v | grep fetch | awk '{print \$2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'\`| head -n1"

# NAV DIR
alias cdc="cd ~/.config"
alias cdn="cd ~/.config/nvim"
alias cdz="cd ~/.config/zsh"
alias cdm="cd ~/.arch"
alias cds="cd ~/.local/bin"
alias cdw="cd ~/.local/share/suckless"

# XDG-REFERENCES
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# PROMPT
autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %B%{$fg[yellow]%}git:%{$fg[white]%}(%{$fg[red]%}%b%{$fg[white]%})"

sysinfo=$(uname -a | awk '{print $2}')
icon=$(echo -n "%B%F{white}%{%G%}")

PROMPT="%B%{$fg[white]%}[%{$fg[red]%}%n%{$fg[white]%} ${icon} %{$fg[yellow]%}${sysinfo} %{$fg[blue]%}%~%{$fg[white]%}]"
PROMPT+="\$vcs_info_msg_0_ %(?:%{$fg[green]%}%{%G➜%} :%{$fg[red]%}%{%G➜%} )"

# VIM-Mode
bindkey -v

export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M vicmd 'y' vi-yank-xclip

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q\033]12;#B48EAD\007'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q\033]12;#e3e3e3\007'
  fi
}

zle-line-init() {
    zle -K viins
    echo -ne "\e[1 q\033]12;#e3e3e3\007"
}

function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -sel c
}

echo -ne '\e[1 q\033]12;#e3e3e3\007'
preexec() { echo -ne '\e[1 q\033]12;#e3e3e3\007' ;}
zle -N zle-keymap-select
zle -N zle-line-init
zle -N vi-yank-xclip
###################### ZSH ##############################

###################### FZF ##############################
# FZF OPTS
EXCLUDE_FZF=" \
--exclude=.git \
--exclude=.cache \
--exclude=.node_modules \
--exclude=.arch \
--exclude=.local \
--exclude=.npm \
--exclude=.ssh \
--exclude=.viminfo \
--exclude=.mozilla \
--exclude=go \
--exclude=Pictures \
--exclude=Public \
"

# FZF DEFAULT OPTS
export FZF_DEFAULT_OPTS=" \
--height 50% \
--layout=reverse \
--border sharp \
--inline-info \
--margin 0,0.40% \
"

# FZF COMMAND
export FZF_DEFAULT_COMMAND="fd -H -L --strip-cwd-prefix"

# FZF COMPLETIONS
export FZF_COMPLETION_TRIGGER="~~"

# FZF ALIAS
alias vd="cd ~ && cd \$($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type d | fzf --preview 'tree -C {}' )"
alias vn="$FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type f | fzf -m --preview 'bat --style=plain --color=always --line-range :500 {}' | xargs -r nvim"
###################### FZF ##############################

# MANPAGE
export MANPAGER="sh -c 'col -bx | bat -l=man '"

# GO
export GOPATH="$XDG_DATA_HOME/go"
