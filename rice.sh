#!/bin/bash
# Dotfiles install script, hosted on https://turbo.ooo/rice

# install paru
sudo pacman -S --needed base-devel
if ! command -v paru &> /dev/null
then
    echo "It seems that you don't have paru installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/paru.git ~/.srcs/paru
	(cd ~/.srcs/paru/ && makepkg -si )
fi

if ! command -v starship &> /dev/null
then
    echo "It seems that you don't have the starship prompt installed, I'll install that for you before continuing."
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
fi

# install dependencies
paru -S --noconfirm exa bspwm sxhkd picom-ibhagwan-git alacritty cava dunst htop neofetch neovim lf polybar rofi zsh python-pywal ttc-iosevka ttc-iosevka-curly otf-apple-sf-pro

# install dots
git clone https://github.com/TurboCheetah/dots.git ~/.dotfiles
cd ~/.dotfiles
./install
