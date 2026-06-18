# START_MANAGED_CONFIG
alias pbcopy='xclip -selection clipboard'
alias n='nvim'
alias code="flatpak run com.visualstudio.code"
abbr d docker
abbr dc docker-compose
function s --description "gsearch with rich highlighting"
    gsearch $argv | python3 $HOME/.local/bin/gsearch_highlight.py
end
export EDITOR=nvim
# Auto-start zellij if not already in a zellij session
alias z='zoxide query -i'
# END_MANAGED_CONFIG
export TERM=xterm
source $HOME/.local/bin/env.fish
alias docker=podman
alias hermes-container="podman run -it --rm -v ~/.hermes:/opt/data:Z -v $(pwd):/opt/repo:Z -w /opt/repo nousresearch/hermes-agent"
