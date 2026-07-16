#!/bin/bash
choice=$(printf "exit\nreboot\nshutdown" | wofi --dmenu --prompt "power" --lines 3)

case "$choice" in
    shutdown) systemctl poweroff ;;
    exit)     hyprctl dispatch exit ;;
    reboot)   systemctl reboot ;;
esac
