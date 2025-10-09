#!/bin/sh
# Author: Casey Walker
#
# Sway script to mark a window using `rofi` for input.
# ------------------------------------------------------------------------------

set -e

mark=$(rofi -dmenu -p 'Mark: ')

swaymsg "mark ${mark}"
