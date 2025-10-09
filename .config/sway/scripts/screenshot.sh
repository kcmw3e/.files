#!/usr/bin/zsh
# Author: Casey Walker
#
# Sway script to take screenshots. If the argument "-r" or "--region" is
# supplied, the screenshot will be taken as a selected region of the screen.
# ------------------------------------------------------------------------------

set -e

function play_shutter_sound() {
  paplay /usr/share/sounds/freedesktop/stereo/camera-shutter.oga
}

readonly datetime=$(date +%Y-%m-%d_%H-%M-%S)
readonly output_filename="screenshot-${datetime}.png"
readonly output_filepath="${HOME}/screenshots/${output_filename}"



case $1 in
  -r | --region)
    readonly region=$(slurp)
  ;;
  *)
    # Nothing to do otherwise
  ;;
esac

if [[ -v region ]]; then
  grim -g "${region}" -t png "${output_filepath}"
else
  grim -t png "${output_filepath}"
fi

play_shutter_sound

notify-send "${output_filepath}"
