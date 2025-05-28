#!/bin/sh
# Author: Casey Walker
#
# Sway script to mark a window using `tofi` for input.
# ------------------------------------------------------------------------------

set -e

# Bare `tofi` will freeze and wait for input from stdin if not redirected from
# '/dev/null'.
mark=$(tofi --prompt='Mark: ' --require-match=false </dev/null)

swaymsg "mark ${mark}"
