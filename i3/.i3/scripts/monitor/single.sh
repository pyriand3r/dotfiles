#!/bin/sh

xrandr --dpi 163 \
    --output eDP --off \
    --output HDMI-A-0 --off \
    --output DisplayPort-0 --off \
    --output DisplayPort-1 --primary --scale 1x1 --mode 3840x2160 --pos 0x0 --rotate normal
