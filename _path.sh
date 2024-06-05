export DENO_INSTALL="$HOME/.deno"
export BUN_INSTALL="$HOME/.bun"

export ANDROID_HOME=$HOME/.var/Android/Sdk

export STARSHIP_CONFIG=~/.config/zsh-config/starship/pastel-powerline.toml
# export STARSHIP_CONFIG=~/.config/zfunc/starship/pure-preset.toml

# Moduler Mojo
export MODULAR_HOME="/home/bns/.modular"
export MOJO_BIN="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"


#Fly CTL
export FLYCTL_INSTALL="/home/bns/.fly"
# export PATH=""


# NVM;
export NVM_DIR="$HOME/.nvm"


# local BOB_NVIM=$HOME/.local/share/bob/nvim-bin

local LOCAL_BIN=$HOME/.local/bin # Local BIN
local GOLANG_BIN=/usr/local/go/bin # Golang 
local BUN_BIN=$BUN_INSTALL/bin # Bun 
local DENO_BIN=$DENO_INSTALL/bin # Deno

export PNPM_HOME=$HOME/.var/pnpm #pnpm
export GOPATH=$HOME/.local/bin/go

# included (local bin, nvim-bin[by-bob] , golang bin , deno bin, bun bin)
PATH1=$GOPATH/bin:$BOB_NVIM:$LOCAL_BIN:$GOLANG_BIN:$DENO_BIN:$BUN_BIN:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
PATH2=$FLYCTL_INSTALL/bin:$MOJO_BIN:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PNPM_HOME

export PATH=$PATH1:$PATH2:$PATH
