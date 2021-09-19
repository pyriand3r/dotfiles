#!/bin/sh

xrandr --dpi 163 \
    --output eDP --primary --scale 1.6x1.6 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output HDMI-A-0 --mode 2560x1440 --scale 1.6x1.6 --pos 3072x0 --rotate normal \
    --output DisplayPort-0 --off \
    --output DisplayPort-1 --off