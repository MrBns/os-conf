# ---------------------------------------------------------------------------
# Desktop only (OC_MODE=desktop).
#
# Everything here needs a graphical session, a GUI editor or a desktop-only
# daemon. None of it makes sense on a VPS, so it never gets loaded there.
# ---------------------------------------------------------------------------

# ExpressVPN
alias vpn='expressvpn'
alias vpnc="expressvpn connect"
alias vpnd="expressvpn disconnect"
alias vpns="expressvpn status"

# Code insider
alias codei="code-insiders"

# Jumping
alias project="j /mnt/Projects/project"

suspend() {
  sudo systemctl suspend
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

# Pick a folder out of the zoxide history and hand it to a GUI app.
#
# Same shape as jnvim/jinvim in _alias.sh: `zoxide query -i` resolves the path
# without moving you, then the app is launched from inside a subshell so it
# inherits the folder as its working directory. Your own shell stays put, so
# there is nothing to cd back from.

# Open Zoxide history folder with code
jcode() {
  local dir
  dir=$(zoxide query -i -- "$@") || return
  (cd "$dir" && code .)
}

# Open Zoxide history folder with zed
jzed() {
  local dir
  dir=$(zoxide query -i -- "$@") || return
  (cd "$dir" && zed .)
}

# Open folder from Zoxide history in the file manager
jopen() {
  local dir
  dir=$(zoxide query -i -- "$@") || return
  (cd "$dir" && xdg-open .)
}
