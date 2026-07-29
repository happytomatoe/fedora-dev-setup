# START_MANAGED_CONFIG
# Tip: add secrets to ~/.config/fish/conf.d/secrets.fish

alias pbcopy='xsel --clipboard --input'
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
