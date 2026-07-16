#!/bin/bash
cd ~/.password-store

# Налаштування для Wayland
DMENU="wofi --dmenu -i -M multi-contains -p Select_Password"
# Використовуємо wl-copy/wl-paste замість xclip
CLIP_COPY="wl-copy"
CLIP_PASTE="wl-paste"

HISTORY_FILE="$HOME/.cache/passmenu_history"
touch "$HISTORY_FILE"

PASSWORDS=$(find ./ -type f ! -path "*/.*" | sed "s|$HOME/.password-store/||" | sed 's/.gpg$//' | sed 's|^\./||')
HISTORY=$(grep -Fx -f <(echo "$PASSWORDS") "$HISTORY_FILE" 2>/dev/null)
MERGED=$(printf "%s\n" "$HISTORY" "$PASSWORDS" | awk '!seen[$0]++')

declare -A DISPLAY_MAP
while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  display="${path//otpauth\//otp/}"
  DISPLAY_MAP["$display"]="$path"
done <<< "$MERGED"

DISPLAY_LIST=$(echo "$MERGED" | sed 's|otpauth/|otp/|g')
PASSWORD_DISPLAY=$(echo "$DISPLAY_LIST" | $DMENU)
[ -z "$PASSWORD_DISPLAY" ] && exit 0
PASSWORD="${DISPLAY_MAP[$PASSWORD_DISPLAY]}"
[ -z "$PASSWORD" ] && exit 0
grep -Fxv "$PASSWORD" <<< "$MERGED" | awk -v p="$PASSWORD" 'BEGIN { print p } { print }' > "$HISTORY_FILE"

SECRET=$(pass show "$PASSWORD")
FIRST_LINE=$(echo "$SECRET" | sed -n '1p')
CURRENT=$($CLIP_PASTE 2>/dev/null)

if [[ "$FIRST_LINE" == otpauth://* ]]; then
  # pass otp копіює сам, але переконайся, що встановлено pass-otp
  pass otp "$PASSWORD" -c
  notify-send "🪪 OTP $PASSWORD copied"
else
  mapfile -t LINES <<< "$SECRET"

  if [ "${#LINES[@]}" -eq 1 ]; then
    echo -n "$FIRST_LINE" | $CLIP_COPY
    notify-send "🔑 Password $PASSWORD copied"
  else
    # Вибір поля через wofi
    LINES[0]="password: ${LINES[0]}"
    RAW_KEYS=$(printf "%s\n" "${LINES[@]}" | sed -n 's/^\([a-zA-Z0-9_-]\+\):.*/\1/p')
    declare -A FIELD_MAP
    while IFS= read -r raw; do
      [[ -z "$raw" ]] && continue
      display="${raw//otpauth/otp}"
      FIELD_MAP["$display"]="$raw"
    done <<< "$RAW_KEYS"
    DISPLAY_KEYS=$(echo "$RAW_KEYS" | sed 's/^otpauth$/otp/')
    SELECTED=$(echo "$DISPLAY_KEYS" | wofi --dmenu -i -M multi-contains -p "Select a field:")
    [ -z "$SELECTED" ] && exit 0
    REAL_KEY="${FIELD_MAP[$SELECTED]}"

    if [[ "$REAL_KEY" == "otpauth" ]]; then
      pass otp "$PASSWORD" -c
      notify-send "🪪 OTP $PASSWORD copied"
    else
      for line in "${LINES[@]}"; do
        key=$(echo "$line" | cut -d ':' -f1 | xargs)
        if [[ "$key" == "$REAL_KEY" ]]; then
          value=$(echo "$line" | cut -d ':' -f2- | sed 's/^ *//')
          echo -n "$value" | $CLIP_COPY
          notify-send "📋 $SELECTED copied"
          break
        fi
      done
    fi
  fi
fi

# Функція відновлення буфера
RESTORE=15
(
  sleep "$RESTORE"
  AFTER=$($CLIP_PASTE 2>/dev/null)
  if [[ "$AFTER" == "$FIRST_LINE" || "$AFTER" == *"password"* ]]; then
    echo -n "$CURRENT" | $CLIP_COPY
    notify-send "🧲 Clipboard restored"
  fi
) &
