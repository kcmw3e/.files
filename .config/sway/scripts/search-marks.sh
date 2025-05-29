#!/bin/sh
# Author: Casey Walker
#
# Sway script to search for marked windows and focus one using `tofi` for input.
# ------------------------------------------------------------------------------

set -e

# The steps for getting the mark selection from the user are as follows:
# 1. Get a list of the marks from Sway as JSON.
# 2. Parse the JSON for all of the marks, and output them one per line.
# 3. Remove literal `"` marks from the output.
# 4. Get a selection from the user for which mark to focus on.
mark=$(
    swaymsg -t get_marks        \
  | jq '.[]'                    \
  | sed 's/\"//g'               \
  | tofi --prompt-text='Goto: ' \
)

swaymsg [con_mark=${mark}] focus
