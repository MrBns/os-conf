# ---------------------------------------------------------------------------
# Pacman - base word `spa` (sudo pacman)
#
# The read-only ones (spas/spaq/spaf) keep the same base for muscle memory
# even though they don't need sudo - only the writing ones actually use it.
# ---------------------------------------------------------------------------
alias spa="sudo pacman"
alias spau="sudo pacman -Syu"         # sync + upgrade everything
alias spai="sudo pacman -S"           # install
alias spar="sudo pacman -Rns"         # remove + unused deps + config
alias spac="sudo pacman -Sc"          # clean package cache

alias spas="pacman -Ss"               # search repos
alias spaq="pacman -Qs"               # search installed
alias spaf="pacman -F"                # which package owns a file

# Remove orphans - packages nothing depends on any more.
spao() {
  local orphans
  orphans=$(pacman -Qtdq)

  if [[ -z "$orphans" ]]; then
    echo "No orphan packages."
    return 0
  fi

  echo "$orphans"
  sudo pacman -Rns $orphans
}

# paru is intentionally not aliased - it is already short, needs no sudo, and
# the short p* namespace collides with real commands (pr, ps).
# Use it directly:  paru -S <pkg>   paru -Syu   paru -Ss <term>

# ---------------------------------------------------------------------------
# CachyOS specific
# ---------------------------------------------------------------------------
alias mirrors="sudo cachyos-rate-mirrors"
alias hw="chwd"                       # hardware driver tool

# ---------------------------------------------------------------------------
# pacman-contrib helpers
# ---------------------------------------------------------------------------
alias updates="checkupdates"          # list pending updates without syncing
alias pacclean="sudo paccache -rk2"   # keep last 2 versions in the cache
alias pacnew="sudo pacdiff"           # merge .pacnew / .pacsave files

# vim for nvim - only when nvim is actually here, otherwise this breaks vim
# itself on a bare box.
if command -v nvim >/dev/null 2>&1; then
  alias vim="nvim"
fi
