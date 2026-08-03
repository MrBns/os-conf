#Dnf alias
alias sdur="sudo dnf update --refresh"
alias sdu="sudo dnf update"
alias sdug="sudo dnf upgrade"
alias sdugr="sudo dnf upgrade --refresh"
alias sdi="sudo dnf install"
alias sds="sudo dnf search"
alias sdls="sudo dnf list"
alias sdgi="sudo dnf groupinstall"

# vim for nvim - only when nvim is actually here, otherwise this breaks vim
# itself on a bare box.
if command -v nvim >/dev/null 2>&1; then
  alias vim="nvim"
fi