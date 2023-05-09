xsetroot -cursor_name left_ptr &
if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
	xrandr --output HDMI-0 --primary --output DP-2 --right-of HDMI-0
fi

xrandr --dpi 96
xset r rate 220 40

# feh background
feh --no-fehbg --bg-fill $HOME/.wallpapers/848404.jpg &

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

# fix for Discord RPC when running in Flatpak
ln -sf $XDG_RUNTIME_DIR/{app/com.discordapp.Discord,}/discord-ipc-0

# remap capslock to ctrl
setxkbmap -option ctrl:nocaps

# exec dwm
exec dbus-launch --sh-syntax --exit-with-session ~/.local/bin/startdwm
