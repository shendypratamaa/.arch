# dont dupilicated my path
typeset -U PATH

# EXPORT
export TERMINAL="st"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export SHELL_SESSIONS_DISABLE=1
[[ "$PATH" =~ "$HOME/.local/bin" ]] || PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.local/share/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# STARTX
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
