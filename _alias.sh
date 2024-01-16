alias python=python3
alias py=python3

# exa alias for ll
alias ls="exa --color=always --icons --group-directories-first --git"
alias l="exa --color=always --icons --all --group-directories-first --git"
alias ll="exa --oneline --long --color=always --icons --all --group-directories-first --git"

# some alias for sudo;
alias sapt="sudo apt-get"
alias sagi="sudo apt-get install"
alias sau="sudo apt-get update"
alias sadistu="sudo apt-get dist-upgrade"
alias saug="sudo apt-get upgrade"

#ExrpssVpn Alias
alias vpn='expressvpn'
alias vpnc="expressvpn connect"
alias vpnd="expressvpn disconnect"
alias vpns="expressvpn status"

# adding sudo by default
alias ufw='sudo ufw'

# Jumping
alias project="j /mnt/Projects/project"

# vim for nvim
alias vim="nvim"

#Bun (js runtime);
bunr(){
  bun run "$@"
}

# clipboard by xclip;
copy() {
  echo $n | xclip -sel clip
}

copyfile() {
  cat $n | xclip -sel clip
}

jp() {
  PREV_DIR=$(pwd)
  j $1
  pwd
}

jip() {
  PREV_DIR=$(pwd)
  ji $1
  pwd
}

jcode() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  code $(pwd)

  wait
  cd $PREV_DIR
}

jnvim() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  nvim $(pwd)
}

# Alias for git
gac() {
  git add $1
  git commit -m "$2"
}
gitMain() {
  git config user.email "you@example.com"
  git config user.name "Your Name"
}
gitAlt() {
  git config user.email "alt@example.com"
  git config user.name "Your Name"
}

gitWork() {
  git config user.email "work@example.com"
  git config user.name "Your Name"
}

gitUser(){
  git config --get user.name
  git config --get user.email
}

killPort() {
  sudo kill -9 $(sudo lsof -t -i:$1)
}
