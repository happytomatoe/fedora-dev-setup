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
# because you can't live docker
sudo dnf install -y docker-cli
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

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

#pycharm
wget -P ~/Downloads $( curl -s "https://data.services.jetbrains.com/products/releases?code=pcc" | jq -r '.PCC[0].downloads.linux.link')
sudo tar -xzf ~/Downloads/pycharm-community-*.tar.gz -C /opt   

create_desktop_icon(){
    desktop_file_name=$1
    app_path=$2
    executable=$3
    icon=$4

    desktop_app=~/.local/share/applications/$desktop_file_name.desktop
    touch $desktop_app

    desktop-file-edit $desktop_app \
    --set-key=Exec \
    --set-value="${executable}" \
    --set-key=Icon \
    --set-value="${icon}" \
        --set-name="Pycharm community" \
        --set-key="Type" --set-value="Application"
    echo "Desktop shortcut created at $DESKTOP_FILE" 
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





