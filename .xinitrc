xsetroot -cursor_name left_ptr &
if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
	xrandr --output HDMI-0 --primary --output DP-2 --left-of HDMI-0
fi

exec dbus-launch --sh-syntax --exit-with-session bspwm
