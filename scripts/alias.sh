alias mk="touch"
alias mkd="mkdir"
alias nv="nvim"
alias nv.="nvim ."
alias cl="clear"
alias c="clear"
alias d="docker"
alias p="pass"

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
