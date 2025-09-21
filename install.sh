# terminal
sudo dnf install -y ghostty
# something like bash but more interactive
sudo dnf install -y fish
chsh -s $(which fish)
# fuzzy finder
sudo dnf install -y fzf
# jump with z and fuzzy keyword for folder that you've already visited
sudo dnf install -y zoxide 
#fished - plugin manager for fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
# fish plugins
fisher install PatrickF1/fzf.fish
fisher install patrickf1/colored_man_pages.fish
fisher install suizman/fish-top
fisher install oh-my-fish/plugin-foreign-env
fisher install gazorby/fish-abbreviation-tips
fisher install kidonng/zoxide.fish
# TODO add aliases for git
#terminal multiplexer
sudo dnf copr enable varlad/zellij
sudo dnf install -y zellij


# browser
curl -fsS https://dl.brave.com/install.sh | sh

#text editor
sudo dnf install -y neovim
sudo dnf install -y @development-tools;
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git


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



