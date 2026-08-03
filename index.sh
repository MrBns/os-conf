# OC_BASE - the repo root, holds this entrypoint and your untracked local.sh.
# OC_SRC  - the tracked config itself. Everything sourced below lives here.
#           Not exported: the files that read it are sourced into this same
#           shell, so nothing outside ever needs to resolve these paths.
export OC_BASE="$HOME/.config/os-conf"
OC_SRC="$OC_BASE/src"

# Distro detection.
# OS_ID   - exact distro id   (cachyos, fedora, ubuntu, ...)
# OS_LIKE - the family it derives from (arch, debian, ...) - may hold several.
# Pre-set OS_ID before sourcing this file to force a platform.
if [ -r /etc/os-release ]; then
  OS_ID=${OS_ID:-$(. /etc/os-release && printf '%s' "$ID")}
  OS_LIKE=$(. /etc/os-release && printf '%s' "$ID_LIKE")
fi
export OS_ID OS_LIKE

# Machine role.
# desktop - the full setup: themed prompt, GUI editors, clipboard, VPN.
# server  - the trimmed setup for a VPS: plain prompt, none of the GUI bits.
# Pre-set OC_MODE before sourcing this file to pick one; desktop is the default.
OC_MODE=${OC_MODE:-desktop}
case "$OC_MODE" in
  desktop | server) ;;
  *)
    printf 'os-conf: unknown OC_MODE "%s" - falling back to desktop\n' "$OC_MODE" >&2
    OC_MODE=desktop
    ;;
esac
export OC_MODE

oc_is_desktop() { [ "$OC_MODE" = desktop ]; }
oc_is_server() { [ "$OC_MODE" = server ]; }

# Loading Scripts
source $OC_SRC/_path.sh
source $OC_SRC/_service.sh
source $OC_SRC/_alias.sh
source $OC_SRC/_options.sh

# Mode file next, so it can override anything the shared files set.
if [ -f "$OC_SRC/mode-specific/$OC_MODE/alias.sh" ]; then
  source "$OC_SRC/mode-specific/$OC_MODE/alias.sh"
fi

# Machine-local overrides last. This repo is public, so email addresses,
# client paths and anything else identifying live here. Gitignored, and
# absent on a fresh clone - see local.example.sh.
if [ -f "$OC_BASE/local.sh" ]; then
  source "$OC_BASE/local.sh"
fi
