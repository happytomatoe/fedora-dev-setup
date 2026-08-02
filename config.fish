# START_MANAGED_CONFIG
# Tip: add secrets to ~/.config/fish/conf.d/secrets.fish

alias pbcopy='wl-copy'
alias n='nvim'
alias code="flatpak run com.visualstudio.code"
abbr d docker
abbr dc docker-compose
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

# Voice-to-Text: voxtral API key
alias mc='mc -S gotar'

set -gx PATH "/var/home/l/.local/bin" $PATH
alias docker-compose='podman-compose'
# Bundled pi binary (extensions compiled in via `just bundle` in packages/coding-agent)
alias pi-opt='/var/home/l/git/pi/packages/coding-agent/dist/pi'

# Android SDK — single source of truth (referenced by justfile via $ANDROID_PATH)
set -gx ANDROID_PATH /var/home/l/Android/Sdk
set -gx ANDROID_HOME $ANDROID_PATH
fish_add_path $ANDROID_PATH/emulator
fish_add_path $ANDROID_PATH/platform-tools
alias android-studio='/var/home/l/.local/share/JetBrains/Toolbox/apps/android-studio/bin/studio.sh'
abbr --add unset 'set --erase'
set -gx JITI_FS_CACHE $HOME/jitti
alias pi-bun="bun /var/home/l/.bun/install/global/node_modules/@earendil-works/pi-coding-agent/dist/cli.js"

# Api keys
set -gx OPENROUTER_API_KEY (secret-tool lookup api_key openrouter)
set -gx OPENCODE_API_KEY (secret-tool lookup api_key opencode-zen)
set -gx NVIDIA_API_KEY (secret-tool lookup api_key nvidia-nim)
set -gx OPENCODE_GO_WORKSPACE_ID wrk_01KCEHR1TJXG5CP3JBXQ88JEMW
set -gx DEEPGRAM_API_KEY (secret-tool lookup service voice-to-text username deepgram)
set -gx GIT_LFS_SKIP_SMUDGE 1
set -gx HERDR_CONFIG_PATH "$HOME/git/fedora-dev-setup/herdr/config.toml"
abbr -a pr "gh pr view --web"
alias code-review="tuicr"

# Pi timing helper — shows total execution time + top 10 startup timings
function pit --description "Run pi with timing, show total time + top 10 startup timings"
    # Run command and capture output + exit code
    set -l start_time (date +%s%3N 2>/dev/null; or echo (date +%s)000)
    set -l output (env PI_TIMING=1 pi $argv 2>&1)
    set -l exit_code $status
    set -l end_time (date +%s%3N 2>/dev/null; or echo (date +%s)000)

    # Calculate duration in ms then format
    set -l duration_ms (math "$end_time - $start_time")
    set -l duration_secs (printf "%.2f" (math "$duration_ms / 1000.0"))

    echo ""
    echo ________________________________________________________
    echo "Executed in  $duration_secs secs"
    echo ________________________________________________________

    # Extract and show startup timings section
    set -l in_timings 0
    set -l timings ()
    for line in $output
        if string match -q "*Startup Timings*" -- $line
            set in_timings 1
            continue
        end
        if test $in_timings -eq 1
            if string match -q "*---*" -- $line
                # End of a timings section — process what we collected
                if test (count $timings) -gt 0
                    echo ""
                    echo "$line"

                    # Parse timings, extract name and ms value
                    set -l parsed ()
                    for t in $timings
                        set -l name (string replace -r ':\s*\d+ms.*' '' -- $t | string trim)
                        set -l ms_val (string replace -r '.*:\s*(\d+)ms.*' '$1' -- $t | string trim)
                        if test -n "$ms_val"
                            set -a parsed "$ms_val $name"
                        end
                    end

                    # Sort by ms descending, show top 10
                    if test (count $parsed) -gt 0
                        echo ""
                        echo "<top-time-consuming>"
                        set -l sorted (printf '%s\n' $parsed | sort -rn | head -n 10)
                        for entry in $sorted
                            set -l ms (string split ' ' -- $entry)[1]
                            set -l name (string split ' ' -- $entry)[2..]
                            echo "  $name: $ms"ms
                        end
                        echo ""
                    end

                    set timings ()
                end
                set in_timings 1
            else
                # Collect timing lines (skip TOTAL and empty lines)
                if not string match -q "*TOTAL*" -- $line
                    and not string match -q "*<top*" -- $line
                    and test -n (string trim -- $line)
                    set -a timings $line
                end
            end
        end
    end

    return $exit_code
end
