#!/usr/bin/env bash
# Searchable action menu for neru recursive grid (press ? in the grid).
# The grid has already exited and parked the cursor on the selection,
# so every entry acts at the cursor position.

theme=()
[ -f ~/.config/rofi/rofidmenu.rasi ] && theme=(-config ~/.config/rofi/rofidmenu.rasi)

entries=(
  "Left click                    Space|neru action left_click"
  "Right click                   Ctrl+Space|neru action right_click"
  "Middle click                  Shift+M|neru action middle_click"
  "Double click (select word)    -|neru action left_click,left_click"
  "Triple click (select line)    -|neru action left_click,left_click,left_click"
  "Scroll here                   .|neru scroll"
  "Back to the grid              Super+S|neru grid"
  "Select text: grab / let go    Shift+V|neru grid"
  "Start over                    ,|neru grid"
  "Undo last letter              Backspace|neru grid"
  "Nudge cursor                  arrows (Shift fine, Ctrl big)|neru grid"
  "Scroll from the grid          Ctrl+J/K/H/L, Ctrl+D/U page|neru grid"
  "Exit                          Esc|true"
)

choice=$(printf '%s\n' "${entries[@]%%|*}" | rofi -dmenu -i -p "neru" "${theme[@]}") || exit 0
for e in "${entries[@]}"; do
  if [ "${e%%|*}" = "$choice" ]; then
    eval "${e#*|}"
    exit
  fi
done
