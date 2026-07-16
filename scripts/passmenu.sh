#!/bin/bash
cd ~/.password-store

HISTORY_FILE="$HOME/.cache/passmenu_history"
touch "$HISTORY_FILE"

PASSWORDS=$(find ./ -type f ! -path "*/.*" | sed "s|$HOME/.password-store/||" | sed 's/.gpg$//' | sed 's|^\./||')
HISTORY=$(grep -Fx -f <(echo "$PASSWORDS") "$HISTORY_FILE" 2>/dev/null)
MERGED=$(printf "%s\n" "$HISTORY" "$PASSWORDS" | awk '!seen[$0]++')
PASSWORD=$(echo "$MERGED" | dmenu -i -p "Select Password")
[ -z "$PASSWORD" ] && exit 0
grep -Fxv "$PASSWORD" <<< "$MERGED" | awk -v p="$PASSWORD" 'BEGIN { print p } { print }' > "$HISTORY_FILE"

SECRET=$(pass show "$PASSWORD")
FIRST_LINE=$(echo "$SECRET" | sed -n '1p')

if [[ "$FIRST_LINE" == otpauth://* ]]; then
  OTP_CODE=$(pass otp "$PASSWORD")
  xdotool type -- "$OTP_CODE"
  notify-send "🪪 OTP $PASSWORD typed"
else
  mapfile -t LINES <<< "$SECRET"

  if [ "${#LINES[@]}" -eq 1 ]; then
    xdotool type -- "$FIRST_LINE"
    notify-send "🔑 Password $PASSWORD typed"
    exit 0
  fi

  LINES[0]="password: ${LINES[0]}"
  RAW_KEYS=$(printf "%s\n" "${LINES[@]}" | sed -n 's/^\([a-zA-Z0-9_-]\+\):.*/\1/p')
  declare -A FIELD_MAP
  while IFS= read -r raw; do
    [[ -z "$raw" ]] && continue
    display="${raw//otpauth/otp}"
    FIELD_MAP["$display"]="$raw"
  done <<< "$RAW_KEYS"
  DISPLAY_KEYS=$(echo "$RAW_KEYS" | sed 's/^otpauth$/otp/')
  SELECTED=$(echo "$DISPLAY_KEYS" | dmenu -i -p "Select a field:")
  [ -z "$SELECTED" ] && exit 0
  REAL_KEY="${FIELD_MAP[$SELECTED]}"

  if [[ "$REAL_KEY" == "otpauth" ]]; then
    OTP_CODE=$(pass otp "$PASSWORD")
    xdotool type -- "$OTP_CODE"
    notify-send "🪪 OTP $PASSWORD typed"
  else
    for line in "${LINES[@]}"; do
      key=$(echo "$line" | cut -d ':' -f1 | xargs)
      if [[ "$key" == "$REAL_KEY" ]]; then
        value=$(echo "$line" | cut -d ':' -f2- | sed 's/^ *//')
        xdotool type -- "$value"
        notify-send "📋 $SELECTED typed"
        break
      fi
    done
  fi
fi
