#!/usr/bin/zsh
# Author: Casey Walker
#
# Sway script to control system volume. One argument is required and must be one
# of "up", "down", or "mute".
# ------------------------------------------------------------------------------

function play_volume_change_sound() {
  paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
}

# Change the volume using the `pactl` command. One argument *must* be supplied
# which specifies the volume change (any others are ignored). It should be a
# valid argument that can be passed on to the `pactl` command, such as `"+1%"`.
function change_volume_by() {
  readonly volume_change=$1
  pactl set-sink-volume @DEFAULT_SINK@ "${volume_change}"
}

case $1 in
  up)
    change_volume_by +5%
    play_volume_change_sound
  ;;
  down)
    change_volume_by -5%
    play_volume_change_sound
  ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
  ;;
esac
