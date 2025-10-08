#!/bin/sh
# Author: Casey Walker
#
# Sway script to search for all windows in the scratchpad and focus one using
# `rofi` for input.
#
# This is adapted from a post I saw on Reddit:
#    https://www.reddit.com/r/i3wm/comments/t39tr7/selecting_i3_windows_from_scratchpad_with_rofi/
# ------------------------------------------------------------------------------

# Using the `jq` command, this script basically does the following:
# 1. Navigate
#     [root node] > [all workspaces] > [all floating nodes in each workspace]
# 2. Filter for the floating nodes that are part of the scratchpad.
# 3. Get the information for each node that was filtered (PID, name, etc.).
jq_script='
    select(.name="root").nodes[]
  | select(.type="workspace").nodes[].floating_nodes[]
  | select(.scratchpad_state!="none")
  | select(.name!=null)
  | select(.pid!=null)
  | .pid,.name,if .marks!=[] then .marks[] else "" end
'

# The selection process essentially works as follows:
# 1. Get the node tree from Sway as JSON.
# 2. Filter through the JSON for scratchpad nodes and their information.
# 3. Output the node information in columns.
# 4. Remove literal `"` marks from the output.
# 5. Get a selection from the user for which window to focus.
# 6. Get the first field (PID) of the selected window.
pid=$(
    swaymsg -t get_tree --raw                                                  \
  | jq "${jq_script}"                                                          \
  | paste - - -                                                                \
  | sed 's/\"//g'                                                              \
  | rofi -dmenu -p "Scratchpad: "                                              \
  | cut -f1                                                                    \
)

swaymsg [pid=${pid}] scratchpad show
