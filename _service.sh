
# Cargo Script
source "$HOME/.cargo/env"

#Evulating Starship ZSH;
eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd j)"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




if [ -f "/home/bns/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "/home/bns/.nix-profile/etc/profile.d/nix.sh"
fi

# # Function to check if a file exists
# file_exists() {
#     if [ -f "$1" ]; then
#         return 0  # True, file exists
#     else
#         return 1  # False, file does not exist
#     fi
# }

# # Function to check if a directory exists
# dir_exists() {
#     if [ -d "$1" ]; then
#         return 0  # True, directory exists
#     else
#         return 1  # False, directory does not exist
#     fi
# }

# # Usage examples:
# # if file_exists "/path/to/file.txt"; then
# #     echo "File exists"
# # fi
# #
# # if dir_exists "/path/to/directory"; then
# #     echo "Directory exists"
# # fi
