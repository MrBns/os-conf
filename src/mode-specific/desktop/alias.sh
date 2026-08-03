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
