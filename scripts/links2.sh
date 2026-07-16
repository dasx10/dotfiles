#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/links-common.sh"

_build_profile_maps

declare -A PROFILE_EMAILS=()
for k in "${!_PROFILE_CACHE[@]}"; do
  PROFILE_EMAILS["$k"]="${_PROFILE_CACHE[$k]}"
done
declare -A EMAIL_TO_DIR=()
for k in "${!_EMAIL_TO_DIR_CACHE[@]}"; do
  EMAIL_TO_DIR["$k"]="${_EMAIL_TO_DIR_CACHE[$k]}"
done

# --- YAML закладки ---
declare -A YAML_URL=()
declare -A YAML_BROWSER=()
declare -A YAML_PROFILE=()
declare -A YAML_PRIVATE=()
ALL_OPTIONS=()

BOOKMARKS_FILES=()
while IFS= read -r -d '' f; do
  BOOKMARKS_FILES+=("$f")
done < <(find "$SCRIPT_DIR/" -maxdepth 1 -name 'links-*.yaml' -print0 2>/dev/null)

if [ ${#BOOKMARKS_FILES[@]} -gt 0 ]; then
  while IFS='|' read -r name url email browser private; do
    profile_dir=$(find_profile_by_email "$email")
    browser_cmd=$(find_browser "$browser")
    url_path="${url#https://}"
    url_path="${url_path#http://}"
    url_path="${url_path%/}"
    display="$url_path"
    [ -n "$name" ] && display="$display ($name)"
    [ "$private" = "true" ] && display="$display [p]"
    [ "$browser_cmd" != "google-chrome" ] && display="$display [$browser_cmd]"

    YAML_URL["$display"]="$url"
    YAML_BROWSER["$display"]="$browser_cmd"
    YAML_PROFILE["$display"]="$profile_dir"
    YAML_PRIVATE["$display"]="$private"
    ALL_OPTIONS+=("$display")
  done < <(cached_parse_yaml "${BOOKMARKS_FILES[@]}")
fi

# --- Збір усіх опцій ---
ALL_OPTIONS+=("${!LINKS[@]}")

for profile_name in "${!PROFILE_EMAILS[@]}"; do
  email="${PROFILE_EMAILS[$profile_name]}"
  while IFS= read -r line; do
    ALL_OPTIONS+=("$line")
  done < <(cached_parse_bookmarks "$HOME/.config/google-chrome/$profile_name/Bookmarks" "$email")
done

# --- Вибір через wofi ---
SELECTED=$(printf "%s\n" "${ALL_OPTIONS[@]}" | wofi --dmenu -i -M multi-contains -p "Select a Link:")

# --- Розбір і відкриття ---
if [ -n "$SELECTED" ]; then
  if [[ -n "${YAML_URL[$SELECTED]}" ]]; then
    open_url "${YAML_BROWSER[$SELECTED]}" "${YAML_URL[$SELECTED]}" "${YAML_PROFILE[$SELECTED]}" "${YAML_PRIVATE[$SELECTED]}"
  elif [[ -n "${LINKS[$SELECTED]}" ]]; then
    url="${LINKS[$SELECTED]}"
    google-chrome --profile-directory="Default" "$url"
  elif [[ "$SELECTED" == *" | "* ]]; then
    url=$(echo "$SELECTED" | awk -F' \\| ' '{print $NF}')
    email=$(echo "$SELECTED" | awk -F' \\| ' '{print $1}')
    profile="${EMAIL_TO_DIR[$email]}"
    if [ -z "$profile" ] && [ -d "$HOME/.config/google-chrome/$email" ]; then
      profile="$email"
    fi
    profile="${profile:-Default}"
    google-chrome --profile-directory="$profile" "$url"
  else
    google-chrome --profile-directory="Default" "$SELECTED"
  fi
fi
