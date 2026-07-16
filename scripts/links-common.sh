#!/bin/bash

declare -A _PROFILE_CACHE=()
declare -A _EMAIL_TO_DIR_CACHE=()

_build_profile_maps() {
  [ ${#_PROFILE_CACHE[@]} -gt 0 ] && return
  for dir in "$HOME/.config/google-chrome"/{Default,"Profile "*}; do
    [ -d "$dir" ] || continue
    local profile_name=$(basename "$dir")
    local email=$(jq -r '.account_info[0].email // ""' "$dir/Preferences" 2>/dev/null)
    [ -z "$email" ] && email="$profile_name"
    local lower_email=${email,,}
    _PROFILE_CACHE["$profile_name"]="$email"
    _EMAIL_TO_DIR_CACHE["$profile_name"]="$profile_name"
    _EMAIL_TO_DIR_CACHE["$lower_email"]="$profile_name"
    [ -n "$email" ] && _EMAIL_TO_DIR_CACHE["${email,,}"]="$profile_name"
  done
}

find_browser() {
  local partial="$1"
  [ -z "$partial" ] && { echo "google-chrome"; return; }
  local lower=$(echo "$partial" | tr '[:upper:]' '[:lower:]')
  local -A BROWSER_MAP=(
    ["google-chrome"]="google-chrome"
    ["chromium"]="chromium"
    ["firefox"]="firefox"
    ["brave-browser"]="brave-browser"
  )
  for b in "${!BROWSER_MAP[@]}"; do
    local lower_b=$(echo "$b" | tr '[:upper:]' '[:lower:]')
    if [[ "$lower_b" == *"$lower"* ]]; then
      echo "${BROWSER_MAP[$b]}"
      return
    fi
  done
  echo "google-chrome"
}

find_profile_by_email() {
  local partial="$1"
  [ -z "$partial" ] && { echo "Default"; return; }
  local lower=${partial,,}

  _build_profile_maps

  for profile_name in "${!_PROFILE_CACHE[@]}"; do
    local email="${_PROFILE_CACHE[$profile_name]}"
    if [[ "${email,,}" == *"$lower"* ]]; then
      echo "$profile_name"
      return
    fi
  done
  echo "Default"
}

open_url() {
  local browser="$1" url="$2" profile="$3" private="$4"
  local args=()

  case "$browser" in
    google-chrome|chromium|brave-browser)
      [ -n "$profile" ] && args+=(--profile-directory="$profile")
      [ "$private" = "true" ] && args+=(--incognito)
      ;;
    firefox)
      [ "$private" = "true" ] && args+=(--private-window)
      ;;
  esac

  "$browser" "${args[@]}" "$url" &>/dev/null &
}

parse_yaml_bookmarks() {
  local files=("$@")
  [ ${#files[@]} -gt 0 ] || return
  python3 -c "
import yaml, sys, re

def process(items, defaults):
    if not isinstance(items, list):
        return
    d = {
        'email': defaults.get('email', ''),
        'browser': defaults.get('browser', ''),
        'private': str(defaults.get('private', '')).lower(),
        'name': defaults.get('name', ''),
    }
    for item in items:
        if not isinstance(item, dict):
            continue
        email = item.get('email', d['email'])
        browser = item.get('browser', d['browser'])
        private = str(item.get('private', d['private'])).lower()
        group_name = d['name']
        if 'entries' in item:
            group_name = item.get('name', d['name'])

        if 'entries' in item:
            child_d = {'email': email, 'browser': browser, 'private': private, 'name': group_name}
            process(item['entries'], child_d)
        else:
            name = item.get('name', '')
            url = item.get('url', '')
            if group_name and name and group_name not in name:
                name = re.sub(r'\s*\([^)]*\)\s*$', '', name).strip()
                name = f'{name} ({group_name})'
            print(f'{name}|{url}|{email}|{browser}|{private}')

for yaml_file in sys.argv[1:]:
    with open(yaml_file) as f:
        data = yaml.safe_load(f) or []

    if isinstance(data, dict):
        top_d = data.get('_defaults', {})
        process(data.get('entries', data.get('items', [])), top_d)
    elif isinstance(data, list):
        process(data, {})
" "${files[@]}"
}

LINKS_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/links"
mkdir -p "$LINKS_CACHE_DIR" 2>/dev/null

cached_parse_yaml() {
  local files=("$@")
  [ ${#files[@]} -gt 0 ] || return
  local cache_file="$LINKS_CACHE_DIR/yaml_cache"

  if [ -f "$cache_file" ]; then
    local stale=0
    for f in "${files[@]}"; do
      [ "$f" -nt "$cache_file" ] && { stale=1; break; }
    done
    [ "$stale" -eq 0 ] && { cat "$cache_file"; return; }
  fi
  parse_yaml_bookmarks "${files[@]}" | tee "$cache_file"
}

cached_parse_bookmarks() {
  local bookmarks_path="$1"
  local email="$2"
  [ -f "$bookmarks_path" ] || return
  local safe_name="${bookmarks_path//\//_}"
  local cache_file="$LINKS_CACHE_DIR/bm_${safe_name}"

  if [ -f "$cache_file" ] && [ ! "$bookmarks_path" -nt "$cache_file" ]; then
    cat "$cache_file"
    return
  fi
  jq -r --arg email "$email" '

def extract_domain($url):
  $url | sub("^https?://"; "") | split("/") | .[0];

def walk:
  if type == "object" and .children then
    .children[] | walk
  elif type == "object" and .url then
    if .name == "" or .name == null then
      $email + " | " + extract_domain(.url) + " | " + .url
    else
      $email + " | " + .name + " | " + .url
    end
  else empty end;

[.roots.bookmark_bar, .roots.other, .roots.synced]
| map(select(. != null))
| map(walk)
| flatten[]
' "$bookmarks_path" | tee "$cache_file"
}
