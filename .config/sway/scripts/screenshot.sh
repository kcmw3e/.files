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
readonly output_filepath="${HOME}/Downloads/${output_filename}"

function take_fullscreen_screenshot() {
    grim -t png "${output_filepath}"
}

function take_region_screenshot() {
    # Can't be set using `readonly` since that would overwrite the exit status.
    # I also tried using `readonly` on the line following the exit status
    # assignment, but that seemed to just overwrite the variable with an empty
    # value.
    region=$(slurp)
    readonly exit_status=$?

    printf "Region: %s\n" "${region}"

    # TODO: add check for `region` being empty
    if [[ "${exit_status}" == 0 ]] then
      grim -g "${region}" -t png "${output_filepath}"
    else
      exit 1
    fi
}

case $1 in
  -r | --region)
    take_region_screenshot
    play_shutter_sound
  ;;
  *)
    take_fullscreen_screenshot
    play_shutter_sound
  ;;
esac

notify-send "${output_filename}"
