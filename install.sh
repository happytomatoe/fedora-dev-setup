# terminal
sudo dnf install -y ghostty

sudo dnf install -y zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

#zsh plugins
# 1)minimal:
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 2) Alternative - https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df
#git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
#git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
#git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
#sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' ~/.zshrc

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
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl restart snapd
sudo snap install intellij-idea-community --classic

#atuin 
sudo dnf install -y atuin
echo 'eval "$(atuin init zsh)"' >> ~/.zshrc
atuin import auto

