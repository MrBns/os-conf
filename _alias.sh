alias python=python3
alias py=python3

# exa alias for ll
alias ls="eza --color=always --icons --group-directories-first --git"
alias l="eza --color=always --icons --all --group-directories-first --git"
alias ll="eza --oneline --long --color=always --icons --all --group-directories-first --git"

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
  if [ -f "$OC_BASE/platform-specific/$_os/alias.sh" ]; then
    source "$OC_BASE/platform-specific/$_os/alias.sh"
    break
  fi
done
unset _os

#ExrpssVpn Alias
alias vpn='expressvpn'
alias vpnc="expressvpn connect"
alias vpnd="expressvpn disconnect"
alias vpns="expressvpn status"

# Rust Cargo Alias
alias cr="cargo run"
alias crq="cargo run -q"
alias crr="cargo run  --  "

# for systemctl;
# alias systemctl='sudo systemctl'
alias sctl="sudo systemctl"

# adding sudo by default
alias ufw='sudo ufw'

# Jumping
alias project="j /mnt/Projects/project"


#neovim alias
# alias nvim="/opt/nvim-linux-x86_64/bin/nvim"


#Bun (js runtime);
br(){
  bun run "$@"
}

#Deno (js Runtime)
dt(){
  deno task "$@"
}


# clipboard - wl-copy under Wayland, xclip under X11
oc_clip() {
  if command -v wl-copy >/dev/null 2>&1; then
    wl-copy
  elif command -v xclip >/dev/null 2>&1; then
    xclip -sel clip
  else
    echo "copy: install wl-clipboard (Wayland) or xclip (X11)" >&2
    return 127
  fi
}

copy() {
  printf '%s' "$*" | oc_clip
}

copyfile() {
  oc_clip < "$1"
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

#  Code insider
alias codei="code-insiders"


# Open Zoxide history folder with code
jcode() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  code "$(pwd)"

  wait
  cd $PREV_DIR
}

# Open Zoxide history folder with zed
jzed() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  zed "$(pwd)"

  wait
  cd $PREV_DIR
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

#Open folder from Zoxide history
jopen() {
  PREV_DIR=$(pwd)

  ji "$1"

  if [ $? -ne 0 ]; then
    echo "Stopped by User"
    return 130
  fi

  wait
  xdg-open "$(pwd)"
}




# Alias for git

gsub(){
    git submodule $@
}

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

suspend(){
  sudo systemctl suspend
}

killPort() {
  sudo kill -9 $(sudo lsof -t -i:$1)
}
