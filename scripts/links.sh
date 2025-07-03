#!/bin/bash

# --- Фіксовані посилання з тегами ---
declare -A LINKS=(
)

# --- Мапа профілів для префіксів ---
declare -A PROFILES=(
  [W]="Profile 1"
  [P]="Default"
)

# --- Парсинг закладок профілю ---
parse_bookmarks() {
  local profile_prefix="$1"
  local profile_name="$2"
  local bookmarks_path="$HOME/.config/google-chrome/$profile_name/Bookmarks"

  [ -f "$bookmarks_path" ] || return

  jq -r --arg tag "$profile_prefix" '
    def extract_domain($url):
      $url
      | sub("^https?://"; "")
      | split("/") | .[0];

    def walk:
      if type == "object" and .children then
        .children[] | walk
      elif type == "object" and .url then
        if .name == "" or .name == null then
          "[" + $tag + "] " + extract_domain(.url) + " | " + .url
        else
          "[" + $tag + "] " + .name + " | " + .url
        end
      else empty end;

    [.roots.bookmark_bar, .roots.other, .roots.synced]
    | map(select(. != null))
    | map(walk)
    | flatten[]
  ' "$bookmarks_path"
}

# --- Збір усіх опцій ---
ALL_OPTIONS=("${!LINKS[@]}")

for prefix in "${!PROFILES[@]}"; do
  name="${PROFILES[$prefix]}"
  while IFS= read -r line; do
    ALL_OPTIONS+=("$line")
  done < <(parse_bookmarks "$prefix" "$name")
done

# --- Вибір через dmenu ---
SELECTED=$(printf "%s\n" "${ALL_OPTIONS[@]}" | dmenu -i -p "Select a Link:")

# --- Розбір і відкриття ---
if [ -n "$SELECTED" ]; then
  if [[ -n "${LINKS[$SELECTED]}" ]]; then
    url="${LINKS[$SELECTED]}"
    prefix="${SELECTED:1:1}"
    profile="${PROFILES[$prefix]:-Default}"
    google-chrome --profile-directory="$profile" "$url"
  elif [[ "$SELECTED" =~ \| ]]; then
    url=$(echo "$SELECTED" | awk -F' | ' '{print $NF}')
    prefix=$(echo "$SELECTED" | cut -c2)
    profile="${PROFILES[$prefix]:-Default}"
    google-chrome --profile-directory="$profile" "$url"
  else
    curl -s "https://api.shrtco.de/v2/shorten?url=$SELECTED" | jq -r '.result.short_link'
    google-chrome --profile-directory="Default" "$SELECTED"
  fi
fi
