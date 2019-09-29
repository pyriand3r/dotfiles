#!/usr/bin/env sh

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  --socket ~/.config/xidlehook.sock \
  --not-when-fullscreen \
  --timer normal 30 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  --timer primary 120 \
    'i3lock -c 000000; xset dpms force off; xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
    '' \
  --timer normal 900 \
    'systemctl suspend' \
    ''
