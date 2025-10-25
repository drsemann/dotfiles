#!/bin/bash

layouts=(
    "󰙀 Horizontal Split      Shift+Control+1"
    "󰕴 Vertical Split        Shift+Control+2"
    "󰝘 Tabbed               Shift+Control+3"
    "󰕬 Stacked              Shift+Control+4"
    "󰕮 Toggle Split          Shift+Control+5"
)

selected=$(printf "%s\n" "${layouts[@]}" | rofi -dmenu -i -p "Select Layout" -line-padding 4 -hide-scrollbar -theme ~/.config/sway/rofi/config.rasi)

# Extract just the first two fields (layout name)
layout_name=$(echo "$selected" | awk '{print $1, $2}')

case "$layout_name" in
    "󰙀 Horizontal") swaymsg "layout splith; border pixel 4" ;;
    "󰕴 Vertical") swaymsg "layout splitv; border pixel 4" ;;
    "󰝘 Tabbed") swaymsg "layout tabbed; border normal 4" ;;
    "󰕬 Stacked") swaymsg "layout stacking; border normal 4" ;;
    "󰕮 Toggle") swaymsg "layout toggle split; border pixel 4" ;;
    *) exit 0 ;;  # Exit on cancel
esac
