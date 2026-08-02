export OC_BASE="$HOME/.config/os-conf"

# Distro detection.
# OS_ID   - exact distro id   (cachyos, fedora, ubuntu, ...)
# OS_LIKE - the family it derives from (arch, debian, ...) - may hold several.
# Pre-set OS_ID before sourcing this file to force a platform.
if [ -r /etc/os-release ]; then
  OS_ID=${OS_ID:-$(. /etc/os-release && printf '%s' "$ID")}
  OS_LIKE=$(. /etc/os-release && printf '%s' "$ID_LIKE")
fi
export OS_ID OS_LIKE

# Loading Scripts
source $OC_BASE/_path.sh
source $OC_BASE/_service.sh
source $OC_BASE/_alias.sh
source $OC_BASE/_options.sh
source $OC_BASE/_project_opener.sh
