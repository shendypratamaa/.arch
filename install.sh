#!/bin/bash

mydir=(
   X11
   git
   lazygit
   neofetch
   nvim
   sxiv
   wallpaper
   zathura
   zsh
   gtk-3.0
   dunst
   sxhkd
   local
)

install() {
   # DOTFILES
   if [[ -d "$HOME/.minimal-ways" ]]; then
      # CONFIG
      cd "$HOME/.minimal-ways" && stow -v "${mydir[@]}"
      ln -sfv "$HOME/.minimal-ways/.vimrc" "$HOME/.vimrc"
      ln -sfv "$HOME/.minimal-ways/.xinitrc" "$HOME/.xinitrc"
      ln -sfv "$HOME/.minimal-ways/.zprofile" "$HOME/.zprofile"

      # ZSH
      if [[ -d "$HOME/.config/zsh" ]]; then
         mkdir -p "$HOME/.config/zsh/plugins"
         cd "$HOME/.config/zsh/plugins" &&
            git clone https://github.com/zsh-users/zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-completions
      fi

      # DWM
      if [[ -d "$HOME/.local/share" ]];then
         mkdir -p "$HOME/.local/share"
         cd "$HOME/.local/share" && git clone https://github.com/shendypratamaa/suckless
      fi

   fi
}

if [ "$1" = "-go" ]; then
   echo "========================= Process Start ... ============================== "
   install
   echo "========================= Process Complete ... ============================== "
   exit
else
   echo "Please run install -go"
fi
