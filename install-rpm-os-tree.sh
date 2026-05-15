# install layered packages
sudo rpm-ostree install \
  keepassxc \
  fish \
  zellij \
  neovim \
  code

# enable COPR for zellij (before install if needed)
if [ ! -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:varlad:zellij.repo ]; then
  sudo curl -L \
    -o /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:varlad:zellij.repo \
    https://copr.fedorainfracloud.org/coprs/varlad/zellij/repo/fedora-$(rpm -E %fedora)/varlad-zellij-fedora-$(rpm -E %fedora).repo
fi

# vscode repo
if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

  sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
fi

# apply changes
sudo systemctl reboot
