
# Cargo Script
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

#Evulating Starship ZSH;
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd j)"
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Check if mise binary exists and run it if available
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi


if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
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
