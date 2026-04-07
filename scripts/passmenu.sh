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
SECOND_LINE=$(echo "$SECRET" | sed -n '2p')
CURRENT=$(xclip -o -selection clipboard 2>/dev/null)

if [[ "$FIRST_LINE" == otpauth://* ]]; then
  pass otp "$PASSWORD" -c
  notify-send "🪪 OTP $PASSWORD copied"
else
  mapfile -t LINES <<< "$SECRET"

  if [ "${#LINES[@]}" -eq 1 ]; then
    echo -n "$FIRST_LINE" | xclip -selection clipboard
    notify-send "🔑 Password $PASSWORD copied"
    exit 0
  fi

  LINES[0]="password: ${LINES[0]}"
  SELECTED=$(printf "%s\n" "${LINES[@]}" | sed -n 's/^\([a-zA-Z0-9_-]\+\):.*/\1/p' | dmenu -i -p "Select a field:")
  for line in "${LINES[@]}"; do
    key=$(echo "$line" | cut -d ':' -f1 | xargs)
    if [[ "$key" == "$SELECTED" ]]; then
      value=$(echo "$line" | cut -d ':' -f2- | sed 's/^ *//')
      echo -n "$value" | xclip -selection clipboard
      notify-send "📋 $SELECTED copied"
      break
    fi
  done
fi

RESTORE=15
restore () {
  AFTER=$(xclip -o -selection clipboard 2>/dev/null)
  if [[ "$AFTER" == "$FIRST_LINE" ]]; then
    if echo $SECRET | grep $CURRENT > /dev/null; then
      CURRENT=""
    else 
      echo -n "$CURRENT" | xclip -selection clipboard
      notify-send "🧲 Clipboard restored"
    fi
  fi
}

sleep "$RESTORE" && restore &
