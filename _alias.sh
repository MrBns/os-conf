alias python=python3
alias py=python3

# exa alias for ll
alias ls="eza --color=always --icons --group-directories-first --git"
alias l="eza --color=always --icons --all --group-directories-first --git"
alias ll="eza --oneline --long --color=always --icons --all --group-directories-first --git"

# Base Directory
BASE="$HOME/.config/zsh-config"

# Check if the OS is Fedora or Ubuntu
if [[ "$OS_ID" == "ubuntu" ]]; then
  source $BASE"/platform-specific/ubuntu/alias.sh"
elif [[ "$OS_ID" == "fedora" ]]; then
  source $BASE"/platform-specific/fedora/alias.sh"
fi

#ExrpssVpn Alias
alias vpn='expressvpn'
alias vpnc="expressvpn connect"
alias vpnd="expressvpn disconnect"
alias vpns="expressvpn status"


# for systemctl;
# alias systemctl='sudo systemctl'
alias syctl="sudo systemctl"

# adding sudo by default
alias ufw='sudo ufw'

# Jumping
alias project="j /mnt/Projects/project"


#Bun (js runtime);
br(){
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

# initialization stuff;
init_cp(){
  mkdir  $cwd+'.bin'
  touch "input.txt"
  touch 'output.txt'
}




killPort() {
  sudo kill -9 $(sudo lsof -t -i:$1)
}
