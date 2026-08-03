alias python=python3
alias py=python3

# eza when it is installed, plain ls when it is not - a fresh VPS usually is not.
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --color=always --icons --group-directories-first --git"
  alias l="eza --color=always --icons --all --group-directories-first --git"
  alias ll="eza --oneline --long --color=always --icons --all --group-directories-first --git"
else
  alias ls="ls --color=auto"
  alias l="command ls --color=auto -A"
  alias ll="command ls --color=auto -lAh"
fi

# ast-grep. `asg` always works; `sg` (the name upstream uses for its own
# binary) is only taken when nothing on the system provides it, so this
# can never shadow a real sg that shows up later.
alias asg="ast-grep"
if ! command -v sg >/dev/null 2>&1; then
  alias sg="ast-grep"
fi

# Load the platform alias file: exact distro id first, then its family.
# CachyOS has no dir of its own, so it falls through to arch/ via ID_LIKE.
# ${=OS_LIKE} forces word splitting - ID_LIKE can hold several ids.
for _os in "$OS_ID" ${=OS_LIKE}; do
  if [ -f "$OC_SRC/platform-specific/$_os/alias.sh" ]; then
    source "$OC_SRC/platform-specific/$_os/alias.sh"
    break
  fi
done
unset _os


# for systemctl;
# alias systemctl='sudo systemctl'
alias sctl="sudo systemctl"

# adding sudo by default
alias ufw='sudo ufw'


#neovim alias
# alias nvim="/opt/nvim-linux-x86_64/bin/nvim"


#Bun (js runtime);
br(){
  bun run "$@"
}


jpwd() {
  PREV_DIR=$(pwd)
  j $1
  pwd
}

jpwd() {
  PREV_DIR=$(pwd)
  ji $1
  pwd
}

# Open Zoxide Hisotry folder with Nvim
jnvim() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  nvim "$(pwd)"
}


# Alias for git

gitsub(){
    git submodule $@
}

gitac() {
  git add $1
  git commit -m "$2"
}

# The per-account identity switchers live in local.sh - they carry email
# addresses and this repo is public. See local.example.sh.
gitUser(){
  git config --get user.name
  git config --get user.email
}

# initialization stuff;
init_ctp(){
  mkdir  $cwd+'.bin'
  touch "input.txt"
  touch 'output.txt'
}


poweroff(){
  sudo systemctl poweroff
}
reboot(){
  sudo systemctl reboot
}

killPort() {
  sudo kill -9 $(sudo lsof -t -i:$1)
}
