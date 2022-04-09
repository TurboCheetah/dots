# autologin
set -l tty (tty)
if test "$tty" = "/dev/tty1"
  pgrep dwm || startx "$HOME/.xinitrc"
end

# disable "welcome to fish"
set fish_greeting
