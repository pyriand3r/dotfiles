#!/usr/bin/env sh

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

xidlehook \
  --socket ~/.config/xidlehook.sock \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 120 \
    'blurlock' \
    '' \
  --timer 300 \
    'i3lock -c 000000; xset dpms force off' \
    '' \
  --timer 900 \
    'systemctl suspend' \
    ''