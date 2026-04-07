#!/bin/sh
awk '/SwapTotal/ {t=$2} /SwapFree/ {f=$2} END {
  used=(t-f)/1024/1024
  total=t/1024/1024
  printf(" swap: %.1fG/%.1fG", used, total)
}' /proc/meminfo

