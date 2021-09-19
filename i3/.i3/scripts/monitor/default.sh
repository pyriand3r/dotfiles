#!/bin/sh

xrandr --dpi 163 \
    --output eDP --mode 1920x1080 --scale 1.6x1.6 --pos 0x0 --rotate normal \
    --output HDMI-A-0 --off --output DisplayPort-0 --off \
    --output DisplayPort-1 --primary --mode 3840x2160 --pos 3072x0 --rotate normal --scale 0.9999x0.9999

