#!/bin/bash
# Dotfiles install script, hosted on https://turbo.ooo/rice

# install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# install dependencies
paru -S --noconfirm bspwm sxhkd picom-ibhagwan-git alacritty cava dunst htop neofetch neovim polybar rofi zsh pywal-git

# install dots
git clone https://github.com/TurboCheetah/dots.git ~/.dotfiles
cd ~/.dotfiles
./install
