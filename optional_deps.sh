#!/bin/bash

# install paru
sudo pacman -S --needed base-devel git
if ! command -v paru &> /dev/null
then
    echo "It seems that you don't have paru installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/paru.git ~/.srcs/paru
	(cd ~/.srcs/paru/ && makepkg -si )
fi

# install dependencies
paru -S --noconfirm brave-bin thunar visual-studio-code-bin spotify spicetify-cli powercord-electron-git
