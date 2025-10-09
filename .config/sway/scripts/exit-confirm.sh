#!/bin/sh
# Author: Casey Walker
#
# Sway script to run when the exit keybind has been triggered. This will give
# the user an option to select "Yes" or "No" to confirm exiting.
# ------------------------------------------------------------------------------

set -e

# Prompt for user to select "Yes" or "No".
option=$(printf "Yes\nNo\n" | rofi -dmenu -p 'Exit Sway? ')

if [ ${option} == "Yes" ]; then
  swaymsg exit
fi
