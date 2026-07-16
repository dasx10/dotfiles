#!/bin/bash

PROMPTS_DIR="$HOME/.config/scripts/prompts"

if [ ! -d "$PROMPTS_DIR" ]; then
    notify-send "promptmenu" "Directory $PROMPTS_DIR not found"
    exit 1
fi

~/.config/scripts/eng.sh
sleep 0.1

FILES=$(find "$PROMPTS_DIR" -type f | sed "s|^$PROMPTS_DIR/||")
[ -z "$FILES" ] && notify-send "promptmenu" "No prompt files found" && exit 0

SELECTED=$(echo "$FILES" | dmenu -i -p "Select prompt:")
[ -z "$SELECTED" ] && exit 0

FILE_PATH="$PROMPTS_DIR/$SELECTED"
[ ! -f "$FILE_PATH" ] && notify-send "promptmenu" "File $SELECTED not found" && exit 1

TEXT=$(cat "$FILE_PATH")

SAVED_CLIP=$(xclip -selection clipboard -o 2>/dev/null)
SAVED_PRIM=$(xclip -selection primary -o 2>/dev/null)

echo -n "$TEXT" | xclip -selection clipboard
echo -n "$TEXT" | xclip -selection primary

sleep 0.1
xdotool key shift+Insert
sleep 0.3

if [ -n "$SAVED_CLIP" ]; then
    echo -n "$SAVED_CLIP" | xclip -selection clipboard
else
    echo -n "" | xclip -selection clipboard
fi

if [ -n "$SAVED_PRIM" ]; then
    echo -n "$SAVED_PRIM" | xclip -selection primary
else
    echo -n "" | xclip -selection primary
fi

notify-send "promptmenu" "$SELECTED pasted"
