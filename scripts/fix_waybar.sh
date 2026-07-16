#!/bin/zsh
# Чекаємо, поки з'явиться папка з сокетом (max 5 сек)
for i in {1..50}; do
    if [ -d "$XDG_RUNTIME_DIR/hypr" ] && [ "$(ls -A $XDG_RUNTIME_DIR/hypr)" ]; then
        break
    fi
    sleep 0.1
done

# Чистимо і лінкуємо
rm -rf /tmp/hypr
mkdir -p /tmp/hypr
ln -s $XDG_RUNTIME_DIR/hypr/* /tmp/hypr/

# Перезапускаємо Waybar
pkill waybar
waybar &
