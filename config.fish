# START_MANAGED_CONFIG
alias pbcopy='xclip -selection clipboard'
alias n='nvim'
abbr d docker
abbr dc docker-compose
function s --description "gsearch with rich highlighting"
    gsearch $argv | python3 $HOME/.local/bin/gsearch_highlight.py
end
export EDITOR=nvim
# Auto-start zellij if not already in a zellij session
if command -v zellij >/dev/null 2>&1; and not set -q ZELLIJ
    zellij
end
# END_MANAGED_CONFIG
