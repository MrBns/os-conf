export DENO_INSTALL="$HOME/.deno"
export BUN_INSTALL="$HOME/.bun"

export ANDROID_HOME=$HOME/.var/Android/Sdk
export STARSHIP_CONFIG=~/.config/zfunc/starship/pastel-powerline.toml

local BOB_NVIM=$HOME/.local/share/bob/nvim-bin
local LOCAL_BIN=$HOME/.local/bin
local GOLANG_BIN=/usr/local/go/bin
local BUN_BIN=$BUN_INSTALL/bin
local DENO_BIN=$DENO_INSTALL/bin
export GOPATH=$HOME/.local/bin/go

# included (local bin, nvim-bin[by-bob] , golang bin , deno bin, bun bin)
export PATH=$GOPATH/bin:$BOB_NVIM:$LOCAL_BIN:$GOLANG_BIN:$DENO_BIN:$BUN_BIN:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH
