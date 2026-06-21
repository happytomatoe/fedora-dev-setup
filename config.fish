# START_MANAGED_CONFIG
alias pbcopy='xclip -selection clipboard'
alias n='nvim'
alias code="flatpak run com.visualstudio.code"
abbr d docker
abbr dc docker-compose
# Use fd instead of find - show error if user runs find
if command -v fd > /dev/null
    function find --wraps fd --description 'fd is installed - use fd instead of find'
        echo "Error: 'find' is deprecated. Use 'fd' instead." >&2
        echo "  fd <pattern> [path]        # find files by name" >&2
        echo "  fd -e <ext> [path]         # find by extension" >&2
        echo "  fd -t f <pattern>          # find files only" >&2
        echo "  fd -t d <pattern>          # find directories only" >&2
        return 1
    end
end
# Use rg instead of grep - show error if user runs grep
if command -v rg > /dev/null
    function grep --wraps rg --description 'rg is installed - use rg instead of grep'
        echo "Error: 'grep' is deprecated. Use 'rg' instead." >&2
        echo "  rg <pattern> [path]        # search for pattern" >&2
        echo "  rg -i <pattern>            # case insensitive" >&2
        echo "  rg -w <pattern>            # whole word match" >&2
        echo "  rg -l <pattern>            # list matching files" >&2
        return 1
    end
end
function s --description "gsearch with rich highlighting"
    gsearch $argv | python3 $HOME/.local/bin/gsearch_highlight.py
end
export EDITOR=nvim
# Auto-start zellij if not already in a zellij session
# END_MANAGED_CONFIG
export TERM=xterm
source $HOME/.local/bin/env.fish
alias docker=podman
alias hermes-container="podman run -it --rm -v ~/.hermes:/opt/data:Z -v $(pwd):/opt/repo:Z -w /opt/repo nousresearch/hermes-agent"
zoxide init fish | source
abbr --add te 'toolbox enter'
