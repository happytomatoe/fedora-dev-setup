#!/bin/bash

# Prompt for sudo password once and keep it cached
sudo -v
while true; do
  sudo -v
  sleep 60
done &
SUDO_KEEPER_PID=$!
trap "kill $SUDO_KEEPER_PID 2>/dev/null; sudo -k" EXIT

#==============================================================================
# Install and setup various programs
#==============================================================================

# terminal
sudo dnf install -y ghostty
# clipboard
sudo dnf install -y xclip
# something like bash but more interactive
sudo dnf install -y fish
if [ "$SHELL" != "/usr/bin/fish" ]; then
  chsh -s /usr/bin/fish
fi
# fuzzy finder
sudo dnf install -y fzf
# jump with z and fuzzy keyword for folder that you've already visited
sudo dnf install -y zoxide
# terminal file manager
yes | sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi -y
curl -LsSf https://astral.sh/uv/install.sh | sh
# to be able to run npm install -g without sudo
sudo mkdir -p /usr/local/lib/node_modules /usr/local/bin && sudo chown -R $(whoami) /usr/local/lib/node_modules /usr/local/bin
# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# golang
sudo dnf install golang -y
# tldr
cargo install tlrc --locked
#keepassxc
sudo dnf install keepassxc -y

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
fish -c "fisher install yazi-shell/yazi"
fish -c "fisher install jhillyerd/plugin-git"
#terminal multiplexer
if ! sudo dnf copr list --enabled 2>/dev/null | grep -q varlad/zellij; then
  sudo dnf copr enable -y varlad/zellij
fi
sudo dnf install -y zellij

# because you can't live without docker
sudo dnf install -y docker-ce docker-ce-cli containerd docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo groupadd docker || true
sudo usermod -aG docker $USER
# browser
if ! command -v brave-browser &>/dev/null; then
  curl -fsS https://dl.brave.com/install.sh | sh
fi

# vimium for brave
echo "Installing Vimium extension for Brave..."
BRAVE_POLICY_DIR="/etc/brave/policies/managed"
sudo mkdir -p "$BRAVE_POLICY_DIR"
sudo tee "$BRAVE_POLICY_DIR/vimium.json" >/dev/null <<'EOF'
{
  "ExtensionInstallForcelist": ["dbepggeogbaibhgnkncfcbggmnkcfkm;https://clients2.google.com/service/update2/crx"]
}
EOF

#text editor
sudo dnf install -y neovim
sudo dnf install -y @development-tools
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

#vscode
if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
fi
sudo dnf update -y
sudo dnf install -y code
code --install-extension shdhuong.markdown-preview-enhanced

#intellij idea
if [ -z "$(ls -d /opt/idea-* 2>/dev/null)" ]; then
  rm -f ~/Downloads/ideaIC-*.tar.gz*
  IDEA_URL=$(curl -s "https://data.services.jetbrains.com/products/releases?code=IIC" | jq -r '.IIC[0].downloads.linux.link')
  wget -P ~/Downloads "$IDEA_URL"
  sudo tar -xzf ~/Downloads/ideaIC-*.tar.gz -C /opt
fi

#pycharm
if [ -z "$(ls -d /opt/pycharm-community-* 2>/dev/null)" ]; then
  rm -f ~/Downloads/pycharm-community-*.tar.gz*
  PYCHARM_URL=$(curl -s "https://data.services.jetbrains.com/products/releases?code=pcc" | jq -r '.PCC[0].downloads.linux.link')
  wget -P ~/Downloads "$PYCHARM_URL"
  sudo tar -xzf ~/Downloads/pycharm-community-*.tar.gz -C /opt
fi

create_desktop_icon() {
  desktop_file_name=$1
  app_path=$2
  executable=$3
  icon=$4

  mkdir -p ~/.local/share/applications
  desktop_app=~/.local/share/applications/$desktop_file_name.desktop
  touch $desktop_app

  desktop-file-edit $desktop_app \
    --set-key=Exec \
    --set-value="${executable}" \
    --set-key=Icon \
    --set-value="${icon}" \
    --set-name="Pycharm community" \
    --set-key="Type" --set-value="Application"
  echo "Desktop shortcut created at $desktop_app"
}

#pycharm desktop app
PYCHARM_HOME=$(readlink -f /opt/pycharm-community-*)
APP_EXEC="${PYCHARM_HOME}/bin/pycharm"
APP_ICON="${PYCHARM_HOME}/bin/pycharm.svg"
create_desktop_icon "pycharm" $PYCHARM_HOME $APP_EXEC $APP_ICON

#idea desktop shortcut
IDEA_HOME=$(readlink -f /opt/idea-*)
INTELLIJ_BIN_PATH="$IDEA_HOME/bin"
ICON_PATH="$INTELLIJ_BIN_PATH/idea.svg"
create_desktop_icon "intellij-idea-ce" $IDEA_HOME "$INTELLIJ_BIN_PATH/idea" $ICON_PATH

# pin apps to dock (requires active GNOME session)
echo "Pinning apps to dock..."
FAVORITE_APPS=(
  "brave-browser.desktop"
  "code.desktop"
  "intellij-idea-ce.desktop"
  "pycharm.desktop"
  "org.gnome.Nautilus.desktop"
)

VALID_APPS=()
for app in "${FAVORITE_APPS[@]}"; do
  if [ -f "/usr/share/applications/$app" ] || [ -f "$HOME/.local/share/applications/$app" ]; then
    VALID_APPS+=("$app")
  fi
done

if [ ${#VALID_APPS[@]} -gt 0 ]; then
  LIST_STR="["
  for i in "${!VALID_APPS[@]}"; do
    LIST_STR+="'${VALID_APPS[$i]}'"
    [ $i -lt $((${#VALID_APPS[@]} - 1)) ] && LIST_STR+=", "
  done
  LIST_STR+="]"
  gsettings set org.gnome.shell favorite-apps "$LIST_STR"
fi

# disable animation effects
echo "Disabling animation effects..."
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter enable-animations false 2>/dev/null || true

# git settings
git config pull.rebase false

