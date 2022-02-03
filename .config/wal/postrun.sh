#!/bin/bash

dunstconf="${XDG_CONFIG_HOME:-$HOME/.config}/dunst/dunstrc"
source "${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors.sh"
mkdir -p "${dunstconf%/*}"
mv -n "$dunstconf" "$dunstconf.bak"
ln -sf "${XDG_CACHE_HOME:-$HOME/.cache}/wal/dunstrc" "$dunstconf"

pkill dunst; setsid -f dunst