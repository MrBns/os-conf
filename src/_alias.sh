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


# Zoxide helpers. Each one comes as a pair:
#   j*   - take the best match for the query
#   ji*  - list the matches and pick one interactively (needs fzf)
#
# The *pwd pair only *prints* the path - it never moves you. Built on
# `zoxide query` rather than j/ji for exactly that reason: j and ji cd by
# definition, query just resolves. Prints to stdout so it composes:
#   cd "$(jipwd)"      ls "$(jpwd conf)"      cp file "$(jipwd)"
jpwd() {
  zoxide query -- "$@"
}

jipwd() {
  zoxide query -i -- "$@"
}

# The *nvim pair opens the folder in nvim. The cd runs inside a subshell, so
# nvim gets the directory as its own cwd - which is what LSP root detection
# and :find rely on - while your shell never moves and needs no cd back.
# zoxide's chpwd hook still fires in there, so the folder keeps its score.
jnvim() {
  local dir
  dir=$(zoxide query -- "$@") || return
  (cd "$dir" && nvim .)
}

jinvim() {
  local dir
  dir=$(zoxide query -i -- "$@") || return
  (cd "$dir" && nvim .)
}


# Alias for git

gitsub(){
    git submodule "$@"
}

gitac() {
  git add "$1"
  git commit -m "$2"
}



# initialization stuff;
init_ctp(){
  mkdir  "$(pwd)"+'.bin'
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
  # The command substitution is deliberately unquoted - lsof prints one PID per
  # line and every one of them has to reach kill as a separate argument.
  # shellcheck disable=SC2046
  sudo kill -9 $(sudo lsof -t -i:"$1")
}
