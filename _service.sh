
# Cargo Script
source "$HOME/.cargo/env"

#Evulating Starship ZSH;
eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd j)"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion