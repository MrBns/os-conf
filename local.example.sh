# ---------------------------------------------------------------------------
# Local overrides - template.
#
# This repo is public, so anything identifying goes here instead of into the
# tracked files: email addresses, client or employer paths, machine-specific
# shortcuts.
#
#   cp local.example.sh local.sh    # then fill it in
#
# local.sh is gitignored and sourced last by index.sh, so it can override
# anything the shared files set. On a machine where it does not exist nothing
# breaks - the functions below simply are not defined.
# ---------------------------------------------------------------------------

# Git identities - one function per account you commit as.
# `gitUser` (in _alias.sh) prints whichever one is currently active.
#
# gitMain() {
#   git config user.email "you@example.com"
#   git config user.name "Your Name"
# }
#
# gitWork() {
#   git config user.email "you@company.example"
#   git config user.name "Your Name"
# }

# Project shortcuts that name a client or a private path.
#
# open_thatproject() {
#   code --profile=Golang /path/to/the/project
# }
