#!/bin/env sh

killall -q polybar

while [ pgrep -u $UID -x polybar >/dev/null ]; do sleep 1; done

for monitor in $(xrandr -q | grep " connected" | cut -d" " -f1); do
    MONITOR="$monitor" polybar middle &
done
