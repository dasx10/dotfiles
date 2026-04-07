alias mk="touch"
alias mkd="mkdir"
alias nv="nvim"
alias nv.="nvim ."
alias cl="clear"
alias c="clear"
alias d="docker"

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
alias dcd="docker compose up -d"

alias lsf="ls | fzf"

function cw () {
  while true; do clear; bash -c $1;sleep $2;done
}
function goo () {
  google-chrome "https://google.com/search?q=$1"
}
alias chrome=google-chrome

function yank () {
  xclip -selection clipboard $1
}
alias y=yank

alias eng="./eng.sh"

alias wge="sudo systemctl status wg-quick@wg0.service"
alias wgeon="sudo systemctl start wg-quick@wg0.service"
alias wgeoff="sudo systemctl stop wg-quick@wg0.service"

function gcc () {
  npx google-closure-compiler --js=$1 --js_output_file=$2
}

function rstr () {
  tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo
}


function p () {
  if [[ "$1" == "email" || "$1" == "e" ]]; then
    # Перевіряємо, чи надано другий аргумент (шлях до пароля)
    if [ -z "$2" ]; then
      echo "Помилка: Будь ласка, вкажіть шлях до запису пароля. Наприклад: p email my/secret/entry"
      return 1 # Повертаємо код помилки
    fi
    pass show "$2" | grep -i "email" | sed "s/email: //i" | yank
  else
    pass "$@"
  fi
}
function nz () {
  z $1 && nvim .
}

# WORK
COMMON_DIR="/home/dev/doc/work/emcp_common"
alias ecb="cd $COMMON_DIR && npx vitest --run && yarn build && cd - && rm -rf ./node_modules/emcp_common/ && mkdir -p ./node_modules/emcp_common/ && cd ./node_modules/emcp_common/ && cp $COMMON_DIR/package.json ./package.json && cp -r $COMMON_DIR/dist ./dist && cd -"

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
