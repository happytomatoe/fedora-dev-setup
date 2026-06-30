#!/usr/bin/env just

# Source directory (this repo)
REPO_DIR := justfile_directory()

# Run all setup scripts
all: install link-configs install-fonts

# Install layered packages and repos (run first)
install-rpm-os-tree:
    ./install-rpm-os-tree.sh

# Run the install script
install: install-fonts
    #!/bin/env bash
    ./install.sh 2>&1 | tee log.txt

# Create all symlinks
link-configs: link-ghostty-config link-fish-config link-gsearch link-microphone link-bashrc install-wrappers

# Link ghostty config
link-ghostty-config:
    #!/bin/env bash
    mkdir -p ~/.config/ghostty
    ln -sf "{{REPO_DIR}}/ghostty/config" ~/.config/ghostty/config

# Link fish config
link-fish-config:
    #!/bin/env bash
    mkdir -p ~/.config/fish
    ln -sf "{{REPO_DIR}}/config.fish" ~/.config/fish/config.fish

# Link bashrc
link-bashrc:
    #!/bin/env bash
    ln -sf "{{REPO_DIR}}/.bashrc" ~/.bashrc

# Link gsearch highlight script
link-gsearch:
    #!/bin/env bash
    mkdir -p ~/.local/bin
    ln -sf "{{REPO_DIR}}/gsearch_highlight.py" ~/.local/bin/gsearch_highlight.py
    chmod +x ~/.local/bin/gsearch_highlight.py

# Install fonts (idempotent)
install-fonts:
    ./install-fonts.sh

# Link headset microphone config
link-microphone:
    #!/bin/env bash
    mkdir -p ~/.config/wireplumber/bluetooth.lua.d/
    ln -sf "{{REPO_DIR}}/51-bluez-config.lua" ~/.config/wireplumber/bluetooth.lua.d/51-bluez-config.lua

# Install command wrappers
install-wrappers:
    #!/bin/env bash
    mkdir -p ~/.local/bin
    ln -sf "{{REPO_DIR}}/bin/wrappers/find" ~/.local/bin/find
    ln -sf "{{REPO_DIR}}/bin/wrappers/grep" ~/.local/bin/grep
    chmod +x ~/.local/bin/find ~/.local/bin/grep

# Copy config files to home directory
copy-config:
    #!/bin/env bash
    mkdir -p ~/.config/fish
    cp "{{REPO_DIR}}/config.fish" ~/.config/fish/config.fish
    cp "{{REPO_DIR}}/.bashrc" ~/.bashrc
    mkdir -p ~/.local/bin
    cp "{{REPO_DIR}}/gsearch_highlight.py" ~/.local/bin/gsearch_highlight.py
    chmod +x ~/.local/bin/gsearch_highlight.py
