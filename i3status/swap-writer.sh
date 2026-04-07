#!/bin/sh
while :; do
  awk '/SwapTotal/ {t=$2} /SwapFree/ {f=$2} END {
    u=t-f
    printf(" swap: %.1fG/%.1fG (%.0f%%)\n", u/1048576, t/1048576, (u*100)/t)
  }' /proc/meminfo > /tmp/i3status-swap
  sleep 10
done
