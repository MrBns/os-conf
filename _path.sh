export DENO_INSTALL="$HOME/.deno"
export BUN_INSTALL="$HOME/.bun"
export HOMEBREW_BIN="/home/linuxbrew/.linuxbrew/bin"
export ANDROID_HOME=$HOME/.var/Android/Sdk
export ZIG_HOME="/usr/local/zig"
export VLANG_HOME="/usr/local/v"
export NIM_LANG_BIN="$HOME/.nimble/bin"
export ODIN_LANG_HOME=/usr/local/Odin
export PHP_HERD_LITE_BIN="$HOME/.config/herd-lite/bin"
local GOLANG_BIN="/usr/local/go/bin" # Golang
local DART_SDK_BIN="/usr/local/dart-sdk/bin"


# swift 
export SWIFTLY_HOME_DIR="/home/bns/.local/share/swiftly"
export SWIFTLY_BIN_DIR="/home/bns/.local/share/swiftly/bin"
export SWIFTLY_TOOLCHAINS_DIR="/home/bns/.local/share/swiftly/toolchains"


export ENCORE_INSTALL="/home/bns/.encore"
export ENCORE_BIN="$ENCORE_INSTALL/bin"




# Starship Promt Setting
parent_process=$(ps -o comm= -p $(ps -o ppid= -p $$))

if [[ "$parent_process" == "warp" ]]; then
    export STARSHIP_CONFIG="$OC_BASE/starship/tokiyo-night_palestine.toml"
else
    export STARSHIP_CONFIG="$OC_BASE/starship/tokiyo-night_palestine.toml"

fi



# export STARSHIP_CONFIG="$OC_BASE/starship/tokio-night-edited.toml"
# export STARSHIP_CONFIG=~/.config/zfunc/starship/pure-preset.toml

# Moduler Mojo
export MODULAR_HOME="/home/bns/.modular"
export MODULAR_BIN="$MODULAR_HOME/bin"


#Fly CTL
export FLYCTL_INSTALL="/home/bns/.fly"
# export PATH=""


# NVM;
export NVM_DIR="$HOME/.nvm"


local NVIM_BIN=/opt/nvim-linux-x86_64/bin

local LOCAL_BIN=$HOME/.local/bin # Local BIN
local BUN_BIN=$BUN_INSTALL/bin # Bun
local DENO_BIN=$DENO_INSTALL/bin # Deno

export PNPM_HOME=$HOME/.var/pnpm #pnpm
export GOPATH=$HOME/.local/bin/go
local flutter_bin="/usr/local/flutter/bin"

# included (local bin, nvim-bin[by-bob] , golang bin , deno bin, bun bin)
PATH1=$GOPATH/bin:$BOB_NVIM:$LOCAL_BIN:$GOLANG_BIN:$DENO_BIN:$BUN_BIN:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ENCORE_BIN:$VLANG_HOME:$ODIN_LANG_HOME:$DART_SDK_BIN
PATH2=$FLYCTL_INSTALL/bin:$MODULAR_BIN:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PNPM_HOME:$flutter_bin:$HOMEBREW_BIN:$ZIG_HOME:$NIM_LANG_BIN:$NVIM_BIN
PATH3=$SWIFTLY_BIN_DIR


export PATH=$PATH1:$PATH2:$PATH3:$PATH
