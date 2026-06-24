#!/bin/bash

# Prompt for sudo password once and keep it cached
sudo -v
while true; do
  sudo -v
  sleep 60
done &
SUDO_KEEPER_PID=$!
trap "kill $SUDO_KEEPER_PID 2>/dev/null; sudo -k" EXIT

set -x
#==============================================================================
# Install and setup various programs
#==============================================================================

# clipboard
#sudo dnf install -y xclip
# something like bash but more interactive
sudo dnf install -y fish
if [ "$SHELL" != "/usr/bin/fish" ]; then
  if fish -c "exit 0" 2>/dev/null; then
    chsh -s /usr/bin/fish
  fi
fi
# fuzzy finder
sudo dnf install -y fzf
# jump with z and fuzzy keyword for folder that you've already visited
sudo dnf install -y zoxide
# terminal file manager
if ! sudo dnf copr list --enabled 2>/dev/null | grep -q lihaohong/yazi; then
  sudo dnf copr enable -y lihaohong/yazi
fi
sudo dnf install yazi -y
pip install uv
npm config set prefix $HOME/npm
fish -c "fish_add_path $HOME/npm/bin"
# install rust
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
fish -c "fish_add_path $HOME/.cargo/bin"
# golang
sudo dnf install golang -y
fish -c "fish_add_path $HOME/go/bin"
# tldr
cargo install tlrc --locked
#keepassxc
#sudo dnf install keepassxc -y

#fisher - plugin manager for fish (run in fish shell)
if ! fish -c "type -q fisher" 2>/dev/null; then
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi
# fish plugins (run in fish shell)
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install patrickf1/colored_man_pages.fish"
fish -c "fisher install suizman/fish-top"
fish -c "fisher install oh-my-fish/plugin-foreign-env"
fish -c "fisher install gazorby/fish-abbreviation-tips"
fish -c "fisher install kidonng/zoxide.fish"
fish -c "fisher install jhillyerd/plugin-git"

#text editor
sudo dnf install -y neovim
sudo dnf install -y @development-tools
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi
# git
git config --global pull.rebase false
git config --global --add --bool push.autoSetupRemote true
sudo dnf install gh -y
if ! command -v lazygit &>/dev/null; then
  go install github.com/jesseduffield/lazygit@latest
fi

# search
cargo install --locked gsearch-cli

# AI
npm i -g opencode-ai
