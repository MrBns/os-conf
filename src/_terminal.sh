# Terminal integration: tell the terminal where you are and what's running,
# so its tab title and new tabs can follow along (WezTerm, Windows Terminal,
# kitty, foot, ...). Starship sets neither of these itself.
#   OSC 7 - the current directory. New tabs/splits open there, and under WSL
#           it's the ONLY way the terminal can learn the Linux path.
#   OSC 2 - the title: the directory name while idle, the command while it
#           runs.
# Skipped on the bare Linux console and dumb terminals, which would print the
# escapes as junk.

if [[ $TERM != linux && $TERM != dumb ]]; then
  _oc_term_cwd() {
    printf '\e]7;file://%s%s\e\\' "$HOST" "$PWD"
  }

  # %1~ = the last path component, or ~ at home.
  _oc_term_title_idle() {
    print -Pn '\e]2;%1~\a'
  }

  # $1 is the command line as typed: keep its first line, drop control chars.
  _oc_term_title_cmd() {
    local cmd=${1%%$'\n'*}
    print -rn -- $'\e]2;'"${cmd//[[:cntrl:]]/}"$'\a'
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _oc_term_cwd
  add-zsh-hook precmd _oc_term_title_idle
  add-zsh-hook preexec _oc_term_title_cmd
fi
