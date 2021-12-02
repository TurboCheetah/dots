#!/bin/bash
# Dotfiles install script, hosted on https://turbo.ooo/rice

# install paru
sudo pacman -S --needed base-devel
if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have paru installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/paru.git ~/.srcs/paru
	(cd ~/.srcs/paru/ && makepkg -si )
fi

# install dependencies
paru -S --noconfirm exa bspwm sxhkd picom-ibhagwan-git alacritty cava dunst htop neofetch neovim polybar rofi zsh python-pywal

# install dots
git clone https://github.com/TurboCheetah/dots.git ~/.dotfiles
cd ~/.dotfiles
./install
