#!/bin/bash
cd ~/.password-store
# PASSWORD=$(find ~/.password-store/ -type f ! -name ".*" | sed "s|$HOME/.password-store/||" | sed 's/.gpg$//' | dmenu -i -p "Select Password")
PASSWORD=$(find ./ -type f ! -path "*/.*" | sed "s|$HOME/.password-store/||" | sed 's/.gpg$//' | sed 's/.\///' | dmenu -i -p "Select Password")

if [ -n "$PASSWORD" ]; then
  pass -c "$PASSWORD"
  notify-send "Password $PASSWORD copied to clipboard"
fi
