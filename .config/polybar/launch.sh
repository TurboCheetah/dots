#!/bin/env sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar middle &

if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
	polybar middle-mon &
fi
