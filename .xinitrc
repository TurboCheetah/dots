xsetroot -cursor_name left_ptr &
if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
	xrandr --output HDMI-0 --primary --output DP-2 --left-of HDMI-0
fi

xrandr --dpi 96

# feh background
feh --no-fehbg --bg-fill $HOME/.wallpapers/wallhaven-v99jk8_1920x1080.png &

# sxhkd
sxhkd &

# picom
# picom -b

# dunst
dunst > /dev/null 2>&1 &

# pipewire
gentoo-pipewire-launcher &

# slstatus
slstatus &

# exec dwm
exec dbus-launch --sh-syntax --exit-with-session ~/.local/bin/startdwm
