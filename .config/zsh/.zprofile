if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep bspwm || startx "/home/turbo/.xinitrc"
fi
