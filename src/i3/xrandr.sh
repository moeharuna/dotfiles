#!/usr/bin/env bash

if [ "$(xrandr --query | grep -c " connected")" = 2 ]; then
   xrandr --output eDP-1 --off
   xrandr --output HDMI-1 --auto
fi
