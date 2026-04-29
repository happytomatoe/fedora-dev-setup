# START_MANAGED_CONFIG
alias pbcopy='xclip -selection clipboard'
export EDITOR=nvim
export VISUAL=$EDITOR
alias n='nvim'

# Auto-start zellij if not already in a zellij session
if command -v zellij >/dev/null 2>&1; and not set -q ZELLIJ
    zellij
end
# END_MANAGED_CONFIG
