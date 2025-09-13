# terminal
sudo dnf install -y ghostty
# something like bash
sudo dnf install -y zsh
# zsh package/plugin manage
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"



zsh -c "source ~/.zshrc"

#terminal multiplexer
sudo dnf copr enable varlad/zellij
sudo dnf install -y zellij
# start zellij in ghostty
echo '[[ "$TERM" = "xterm-ghostty" ]] && eval "$(zellij setup --generate-auto-start bash)"' >> ~/.zshrc


# browser
curl -fsS https://dl.brave.com/install.sh | sh

#text editor
sudo dnf install -y neovim
sudo dnf install -y @development-tools;
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
sudo dnf install -y fzf

#vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install -y code

#intellij idea
# download latest
wget -P ~/Downloads $( curl -s "https://data.services.jetbrains.com/products/releases?code=IIC" | jq -r '.IIC[0].downloads.linux.link')
sudo tar -xzf ~/Downloads/ideaIC-*.tar.gz -C /opt   

#TODO: fix shortcut
IDEA_HOME=$(readlink -f /opt/idea-)
INTELLIJ_BIN_PATH="$IDEA_HOME/bin"

# Path to IntelliJ IDEA icon (optional but recommended)
ICON_PATH="$INTELLIJ_BIN_PATH/idea.svg"

# Output .desktop file path
DESKTOP_FILE="$HOME/.local/share/applications/intellij-idea-ce.desktop"

# Create the .desktop file content
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Community Edition
Exec=$INTELLIJ_BIN_PATH/idea.sh %f
Icon=$ICON_PATH
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea-ce
StartupNotify=true
EOF

# Make the desktop file executable
chmod +x "$DESKTOP_FILE"

echo "Desktop shortcut created at $DESKTOP_FILE"


#atuin 
sudo dnf install -y atuin
echo 'eval "$(atuin init zsh)"' >> ~/.zshrc
atuin import auto

