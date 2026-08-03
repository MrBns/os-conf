# ---------------------------------------------------------------------------
# Tool environment
# Only variables a tool actually reads at runtime belong here.
# Anything that exists purely to build PATH lives in the array below instead.
# ---------------------------------------------------------------------------
export ANDROID_HOME="$HOME/.var/Android/Sdk"
export BUN_INSTALL="$HOME/.bun"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/.var/pnpm"
export GOPATH="$HOME/.local/bin/go"
export MODULAR_HOME="$HOME/.modular"      # Modular / Mojo
export FLYCTL_INSTALL="$HOME/.fly"        # Fly CTL
export ENCORE_INSTALL="$HOME/.encore"

# swift
export SWIFTLY_HOME_DIR="$HOME/.local/share/swiftly"
export SWIFTLY_BIN_DIR="$SWIFTLY_HOME_DIR/bin"
export SWIFTLY_TOOLCHAINS_DIR="$SWIFTLY_HOME_DIR/toolchains"

# Starship Promt Setting
# Server gets a plain, nerd-font-free prompt that survives a bare TTY.
if oc_is_server; then
  export STARSHIP_CONFIG="$OC_SRC/starship/server.toml"
else
  export STARSHIP_CONFIG="$OC_SRC/starship/tokiyo-night_palestine.toml"
  # export STARSHIP_CONFIG="$OC_SRC/starship/tokio-night-edited.toml"
  # export STARSHIP_CONFIG="$OC_SRC/starship/pure-preset.toml"
fi


# ---------------------------------------------------------------------------
# PATH
#
# Every bin directory, highest priority first. Directories that don't exist on
# this machine are skipped, so it's safe to keep tools listed here that aren't
# installed yet - they simply never reach PATH.
# ---------------------------------------------------------------------------
bin_dirs=(
  # personal
  "$HOME/.local/bin"

  # languages & runtimes
  "/usr/local/go/bin"
  "$GOPATH/bin"
  "$BUN_INSTALL/bin"
  "$DENO_INSTALL/bin"
  "/usr/local/dart-sdk/bin"
  "/usr/local/flutter/bin"
  "/usr/local/zig"
  "/usr/local/Odin"
  "$HOME/.nimble/bin"                       # nim
  "$HOME/.local/v"                          # v
  "$SWIFTLY_BIN_DIR"
  "$HOME/.config/herd-lite/bin"             # php (herd lite)

  # editors
  "/opt/nvim-linux-x86_64/bin"

  # android sdk
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/cmdline-tools/latest/bin"

  # cloud & misc tooling
  "$ENCORE_INSTALL/bin"
  "$FLYCTL_INSTALL/bin"
  "$MODULAR_HOME/bin"
  "$PNPM_HOME"
  "/home/linuxbrew/.linuxbrew/bin"
)

# Keep only the directories that actually exist.
found_dirs=()
for dir in $bin_dirs; do
  if [[ -d "$dir" ]]; then
    found_dirs+=("$dir")
  fi
done

# Put them in front of the system PATH.
# `path` is zsh's array view of $PATH - assign one and the other updates.
# `typeset -U` makes it refuse duplicates, so re-sourcing this file is safe.
typeset -U path
path=($found_dirs $path)
export PATH

unset bin_dirs found_dirs dir
