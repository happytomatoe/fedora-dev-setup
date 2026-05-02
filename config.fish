# START_MANAGED_CONFIG
abbr pbcopy 'xclip -selection clipboard'
alias n='nvim'
abbr d 'docker'
abbr dc 'docker-compose'
# Auto-start zellij if not already in a zellij session
if command -v zellij >/dev/null 2>&1; and not set -q ZELLIJ
    zellij
end
# END_MANAGED_CONFIG
