alias nv="nvim"
alias wge="sudo systemctl status wg-quick@wg0.service"
alias wgeon="sudo systemctl start wg-quick@wg0.service"
alias wgeoff="sudo systemctl stop wg-quick@wg0.service"
alias cl="clear"
alias seten="setxkbmap -layout us ; sleep 0.5s ; setxkbmap -layout 'us,ua' -option ',winkeys' -option 'grp:alt_shift_toggle'"
alias d="docker"

alias npmrs="npm run start"
alias npmrb="npm run build"
alias npmrd="npm run dev"
alias npmi="npm i"
alias npmd="npm i -D"
alias npmg="npm i -g"

function cw () {
  while true; do clear;$1;sleep 1;done
}

write_or_read () {
  if [[ -w "$3" ]]; then
    "$1" "$3"
  elif [[ -r "$3" ]]; then
    "$2" "$3"
  else
    echo "Access Denied"
  fi
}

exec_write_or_read () {
  if [[ -x "$3" ]]; then
    ./"$3"
  else
    write_or_read "$1" "$2" "$3"
  fi
}

do_exec_write_or_read () {
  if [[ -x "$4" ]]; then
    if grep -q "^#!" "$4"; then
      ./"$4"
    else
      "$1" "$4"
    fi
  else
    write_or_read "$1" "$2" "$3" "$4"
  fi
}

over_write_or_read () {
  if [[ -w "$4" ]]; then
    $1 "$4"
  else
    write_or_read "$1" "$2" "$3" "$4"
  fi
}

function goo () {
  google-chrome "https://google.com/search?q=$1"
}

function loc () {
  google-chrome "http://localhost:${1:-3000}"
}

function yank () {
  xclip -selection clipboard $1
}
alias y=yank

alias -s jpg="write_or_read $PIC_EDITOR $PIC_VIEWER"
alias -s png="write_or_read $PIC_EDITOR $PIC_VIEWER"
alias -s ico="write_or_read $PIC_EDITOR $PIC_VIEWER"
alias -s js="do_exec_write_or_read node nvim $TEXT_VIEWER"
alias -s py="do_exec_write_or_read python3 nvim $TEXT_VIEWER"
alias -s sh="exec_write_or_read $EDITOR $TEXT_VIEWER"
alias -s html="over_write_or_read $BROWSER nvim $TEXT_VIEWER"
alias -s htm="write_or_read nvim $TEXT_VIEWER"
alias -s hbs="write_or_read nvim $TEXT_VIEWER"
alias -s css="write_or_read nvim $TEXT_VIEWER"
alias -s scss="write_or_read nvim $TEXT_VIEWER"
alias -s sass="write_or_read nvim $TEXT_VIEWER"
alias -s less="write_or_read nvim $TEXT_VIEWER"
alias -s svg="write_or_read nvim $TEXT_VIEWER"
alias -s xml="write_or_read nvim $TEXT_VIEWER"
alias -s json="write_or_read nvim $TEXT_VIEWER"
alias -s txt="write_or_read nvim $TEXT_VIEWER"
alias -s log=$TEXT_VIEWER
alias -s gitignore="write_or_read $EDITOR $TEXT_VIEWER"
alias -s env="write_or_read $EDITOR $TEXT_VIEWER"
alias -s yaml="write_or_read $EDITOR $TEXT_VIEWER"
alias -s yml="write_or_read $EDITOR $TEXT_VIEWER"
alias -s deb="apt install"
alias -s tf="terraform apply"
alias -s zshrc="source"
alias -s exe="portproton"
alias -s pub="yank"
