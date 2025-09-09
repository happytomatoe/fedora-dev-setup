# terminal
sudo dnf install alacrity
sudo dnf install ghostty

sudo dnf install zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

#zsh plugins
# 1)minimal:
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 2) Alternative - https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' ~/.zshrc

zsh -c "source ~/.zshrc"



#terminal multiplexer
sudo dnf copr enable varlad/zellij
sudo dnf install zellij
# browser
curl -fsS https://dl.brave.com/install.sh | sh

#text editor
sudo dnf install neovim
sudo dnf install @development-tools;
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
# other
sudo dnf install fzf

#nerd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
mkdir ~/.fonts
unzip JetBrainsMono.zip -d ~/.fonts;