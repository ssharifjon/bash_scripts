#!/bin/sh

internal=eDP-1
external=HDMI-1-0

if xrandr | grep "$external connected"; then
    xrandr --output "$external" --mode 2560x1440 --rate 100 --primary --output "$internal" --off
else
    xrandr --output "$internal" --auto --primary --output "$external" --off 
fi
