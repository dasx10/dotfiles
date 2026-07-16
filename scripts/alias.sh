#!/bin/bash
# 1. Гарантуємо завантаження системи комплішенів
[[ -n "$(typeset -f compinit)" ]] || autoload -Uz compinit && compinit

# 2. Ваша прокачана функція d
function d () {
  if [[ "$1" == "up" ]]; then 
    docker compose up -d
  elif [[ "$1" == "down" ]]; then 
    docker compose down
  else 
    docker "$@"
  fi
}

# 3. Розумне автодоповнення
if [ -n "$(typeset -f compdef)" ]; then
    compdef -d d 2>/dev/null
    
    # Якщо встановлено плагін docker-compose, використовуємо його комплішен,
    # бо ваша функція обробляє саме його команди. Якщо ні — бекапимося на звичайний docker.
    if (($+functions[_docker-compose])); then
        compdef _docker-compose d 2>/dev/null
    else
        compdef _docker d 2>/dev/null
    fi
fi

alias mk="touch"
alias mkd="mkdir"
alias nv="nvim"
alias nv.="nvim ."
alias cl="clear"
alias c="clear"

alias nrs="npm run start"
alias nrb="npm run build"
alias nrd="npm run dev"
alias npmr="npm run"
alias npmrs="npm run start"
alias npmrb="npm run build"
alias npmrd="npm run dev"
alias npmu="npm uninstall"
alias npmi="npm i"
alias npmd="npm i -D"
alias npmg="npm i -g"

alias kc="kubectl --kubeconfig"

alias lsf="ls | fzf"
alias gpgflush='systemctl --user stop gpg-agent.service gpg-agent.socket gpg-agent-extra.socket gpg-agent-browser.socket gpg-agent-ssh.socket && systemctl --user start gpg-agent.socket'

function cw () {
  while true; do clear; bash -c $1;sleep $2;done
}
function goo () {
  google-chrome "https://google.com/search?q=$1"
}
alias chrome=google-chrome

# function yank () {
#   if [ -n "$WAYLAND_DISPLAY" ] && [ -S "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/${WAYLAND_DISPLAY:-wayland-0}" ]; then
#     wl-copy < "$1"
#   elif [ -n "$DISPLAY" ]; then
#     xclip -selection clipboard < "$1"
#   else
#     echo "Error: unknown display server" >&2
#     return 1
#   fi
# }

alias y=yank
alias eng="./eng.sh"

# WORK
COMMON_DIR="/home/dev/doc/work/emcp_common"

# 1. Тести та білд самого комону
function _ecb_build {
  local start_dir=$(pwd)
  cd "$COMMON_DIR" || return 1
  
  echo "=> Running tests in emcp_common..."
  if ! yarn test || ! yarn build; then
    echo "❌ Error: Tests or Build failed in emcp_common!" >&2
    cd "$start_dir" || return 1
    return 1
  fi
  cd "$start_dir" || return 1
}

# 2. Перевірка та точковий синк у поточній папці (сама заходить у ./server якщо треба)
function _ecb_common_sync {
  [ -d "./server" ] && cd ./server

  if [ ! -f "./package.json" ] || ! grep -q '"emcp_common"' ./package.json 2>/dev/null; then
    echo "⚠️  Skipping: package.json not found or emcp_common not in dependencies" >&2
    return 1
  fi

  echo "=> Syncing emcp_common to $(pwd)/node_modules..."
  sudo rm -rf ./node_modules/emcp_common/ ./node_modules/.vitest ./node_modules/.cache
  mkdir -p ./node_modules/emcp_common/
  cp "$COMMON_DIR/package.json" ./node_modules/emcp_common/package.json
  cp -r "$COMMON_DIR/dist" "$COMMON_DIR/eslint" ./node_modules/emcp_common/
}

# --- ПУБЛІЧНІ ФУНКЦІЇ ---

# Для одного поточного репозиторію
function ecb {
  _ecb_build && _ecb_common_sync
}

# Для всього стеку однією командою
function ecba {
  local CURDIR=$(pwd)
  
  # Збірка комону на початку
  _ecb_build || return 1

  echo "=== Syncing to repositories and updating containers ==="

  # --- 1. BE ---
  if cd /home/dev/doc/work/emcp_be 2>/dev/null && _ecb_common_sync; then
    if docker compose ps | grep -q "backend0-node"; then
      echo "=> Restarting emcp_be containers..."
      docker compose down && docker compose up app mongodb cache keycloak postgres-kc -d
    fi
  fi

  # --- 2. UI ---
  if cd /home/dev/doc/work/emcp_ui 2>/dev/null && _ecb_common_sync; then
    if docker compose ps | grep -q "frontend-ui"; then
      echo "=> Restarting emcp_ui containers..."
      docker compose down && docker compose up -d
    fi
  fi

  # --- 3. COMMON docker check ---
  if cd /home/dev/doc/work/emcp_common 2>/dev/null; then
    if docker compose ps | grep -q "emcp-common"; then
      echo "=> Restarting emcp_common containers..."
      docker compose down && docker compose up -d
    fi
  fi

  # --- 4. Workload Runner ---
  if cd /home/dev/doc/work/emcp-wr 2>/dev/null && _ecb_common_sync; then
    if docker compose ps | grep -q "workload-runner"; then
      echo "=> Restarting emcp-wr containers..."
      docker compose down && docker compose up -d
    fi
  fi

  cd "$CURDIR" || return 1
  echo "✅ All done!"
}


function u() {
  USERNAME="$1"
  shift

  if [ -z "$USERNAME" ]; then
    echo "username missing"
    return 1
  fi

  if [ -z "$1" ]; then
    echo "command missing"
    return 1
  fi

  xhost +si:localuser:"$USERNAME" >/dev/null 2>&1

  PULSE_SERVER_LOC="$(pactl info | grep 'Server String' | awk '{print $3}')"

  sudo -u "$USERNAME" env \
    DISPLAY=:0 \
    PULSE_SERVER="$PULSE_SERVER_LOC" \
    XDG_RUNTIME_DIR="/run/user/$(id -u "$USERNAME")" \
    "$@"
}

function erun () {
    case "$1" in
        "be")
            cd ~/work/emcp_be/ && \
            git fetch && \
            git pull origin $(git branch --show-current) && \
            cd ./server && \
            ecb && \
            cd .. && \
            docker compose up app mongodb cache keycloak postgres-kc -d && \
            docker logs -f backend0-node
            ;;

        "ui")
            cd ~/work/emcp_ui && \
            git fetch && \
            git pull origin $(git branch --show-current) && \
            ecb && \
            yarn run start:https
            ;;

        "wr")
            cd ~/work/emcp-wr/ && \
            git fetch && \
            git pull origin $(git branch --show-current) && \
            cd ./server && \
            ecb && \
            cd .. && \
            docker compose up workload-runner -d && docker logs workload-runner -f
            ;;

        "off")
            docker kill $(docker ps -q) & tmux kill-server & pkill nvim & pkill node
            ;;
        *)
            echo "Невідомий аргумент."
            return 1
            ;;
    esac
}

function et() {
  sudo tailscale up;
  eval $@;
  sudo tailscale down;
}

function workoff() {
  docker kill $(docker ps -q)
  pkill nvim
  pkill node
  pkill ngrok
  sudo tailscale down
  tmux kill-server
}

gchat() {
    export GEMINI_API_KEY=$(pass tokens/gemini)
    gemini "$@" -m gemini-1.5-pro
}

t () {
  local target_session="$1"

  # Якщо аргументів немає, просто відкриваємо tmux або підключаємось до останнього
  if [ -z "$target_session" ]; then
    tmux attach || tmux new
    return
  fi

  if [ -n "$TMUX" ]; then
    # МИ ВСЕРЕДИНІ TMUX:
    # Перевіряємо, чи сесія вже існує
    if tmux has-session -t "$target_session" 2>/dev/null; then
      tmux switch-client -t "$target_session"
    else
      # Якщо не існує, створюємо в фоні і перемикаємось.
      # Це дає sessionist можливість відпрацювати коректно.
      tmux new-session -d -s "$target_session"
      tmux switch-client -t "$target_session"
    fi
  else
    # МИ ЗОВНІ TMUX:
    # Просто намагаємось підключитись або створити нову
    tmux attach -t "$target_session" 2>/dev/null || tmux new-session -s "$target_session" "sh -c 'sleep 1; tmux attach -t \"$target_session\"'"
  fi
}

nvapi() {
    local socket=""
    
    # 1. Пошук живого сокета
    for s in $(print -N /run/user/1000/nvim*(N) /tmp/nvim*(N) | tr '\0' '\n'); do
        if [ -S "$s" ] && nvim --headless --server "$s" --remote-expr "1" &>/dev/null; then
            socket="$s"
            break
        fi
    done

    if [ -z "$socket" ]; then
        echo "Error: Active Neovim socket not found." >&2
        return 1
    fi

    case "$1" in
        file)     
            nvim --headless --server "$socket" --remote-expr "expand('%:p')"
            ;;
        cursor)   
            nvim --headless --server "$socket" --remote-expr "join(getpos('.')[1:2], ' ')"
            ;;
        mode)     
            nvim --headless --server "$socket" --remote-expr "mode()"
            ;;
        selected) 
            cat /tmp/nvim.seleted 2>/dev/null
            echo ""
            ;;
        *)        
            echo "Usage: nvapi [file|cursor|mode|selected]" >&2
            return 1 
            ;;
    esac
}

openai () {
  local api_key
  local key_file="/tmp/openai_key"

  if [ -n "$2" ]; then
    api_key="$2"
    echo "$2" > "$key_file"
  elif [ -f "$key_file" ] && [ -n "$(cat "$key_file")" ]; then
    api_key="$(cat "$key_file")"
  else
    echo "Error: API key not provided and no cached key found." >&2
    return 1
  fi

  curl -s "https://api.openai.com/v1/chat/completions" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $api_key" \
    -d '{
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "'"$1"'"}]
    }' | jq -r '.choices[0].message.content'
}
