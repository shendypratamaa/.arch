#!/bin/bash

directory=(
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
   lf
   picom
)

initfile=(
   .vimrc
   .xinitrc
   .zprofile
)

install() {
   if [[ -d "$HOME/.arch" ]]; then

      cd "$HOME/.arch" && stow -v "${directory[@]}"

      ln -sfv "$HOME/.arch/user-dirs.dirs" "$HOME/.config"

      for file in "${initfile[@]}"
      do
         ln -sfv "$HOME/.arch/$file" "$HOME/"
      done

      if [[ -d "$HOME/.config/zsh" ]]; then
         mkdir -p "$HOME/.config/zsh/plugins"
         cd "$HOME/.config/zsh/plugins" &&
            git clone https://github.com/zsh-users/zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-completions
      fi

      if [[ -d "$HOME/.local/share" ]]; then
         mkdir -p "$HOME/.local/share"
         cd "$HOME/.local/share" &&
            git clone https://github.com/shendypratamaa/suckless
      fi

   fi
}

if [ "$1" = "-go" ]; then
   echo "========================== Process Start ... ================================"
   install
   echo "========================= Process Complete ... =============================="
   exit
else
   echo "Please run install -go"
fi
