#!/bin/bash

export TZ=Europe/Kyiv

HOUR=$(date +%k | tr -d ' ')
DOW=$(date +%u)                  # 1=Mon, 5=Fri, 6=Sat, 7=Sun

is_workday() { [ "$DOW" -le 5 ]; }
is_worktime() { [ "$HOUR" -ge 9 ] && [ "$HOUR" -lt 18 ]; }

MATTERMOST_ENCLAIVE="https://mattermost.enclaive.cloud/"
MATTERMOST_PERSONAL="https://im.rezet.io/"

if is_workday && is_worktime; then
    # Workspace 1: Chrome — enclaive profile + Mattermost
    google-chrome --disable-gpu --class="ChromeWork" --profile-directory="Profile 5" "$MATTERMOST_ENCLAIVE" &

    # Workspace 2: Chrome — personal profile + Mattermost
    google-chrome --disable-gpu --class="ChromePersonal" --profile-directory="Default" "$MATTERMOST_PERSONAL" &

    # Workspace 3: kitty
    kitty &

    sleep 2
    i3-msg 'workspace number 1'
else
    google-chrome --disable-gpu --class="ChromePersonal" --profile-directory="Default" &
    sleep 1
    i3-msg 'workspace number 2'
fi
