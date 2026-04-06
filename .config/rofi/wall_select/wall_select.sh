#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpaper"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
theme="$SCRIPT_DIR/wall_select.rasi"

CWD="$(pwd)"

cd "$WALL_DIR"

IFS=$'\n'

SELECTED_WALL=$(for a in *.jpg *.png; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -theme ${theme} -p "")

if [ -n "$SELECTED_WALL" ]; then
  ${HOME}/.config/hypr/scripts/set_bg "$WALL_DIR/$SELECTED_WALL"
fi
