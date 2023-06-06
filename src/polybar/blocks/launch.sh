#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/blocks"
pkill polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -q main -c "$DIR/config.ini" &
  done
else
  polybar --reload -q main -c "$DIR/config.ini" &
fi