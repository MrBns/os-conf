# ---------------------------------------------------------------------------
# Server only (OC_MODE=server).
#
# Keep this short. A VPS shell should stay close to a stock one - anything you
# add here is something you will have to remember not to rely on when you land
# on a box that does not have os-conf.
# ---------------------------------------------------------------------------

alias ports="sudo ss -tulpn"        # what is listening, and which process owns it
alias jctl="sudo journalctl"
alias jctlf="sudo journalctl -f"    # follow everything
alias jctlu="sudo journalctl -u"    # one unit:  jctlu nginx -f
