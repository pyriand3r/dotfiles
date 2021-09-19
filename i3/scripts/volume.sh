#!/bin/sh
# higher/lower/mute all amixer devices

# cat /proc/asound/cards to get all cards with ids

# amixer -c <ID> sset PCM,0 5%-|+ to higher/lower volume

# amixer -c <ID> sset PCM,0 unmute|mute to mute/unmute