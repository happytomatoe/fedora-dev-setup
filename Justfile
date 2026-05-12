#!/usr/bin/env just

# Run the install script
install:
    #!/bin/env bash
    ./install.sh 2>&1 | tee log.txt
    mkdir -p ~/.config/ghostty ~/.local/bin
    if ! cmp -s ghostty/config.ghostty ~/.config/ghostty/config.ghostty 2>/dev/null; then
        cp ghostty/config.ghostty ~/.config/ghostty/config.ghostty
    fi
    if ! cmp -s gsearch_highlight.py ~/.local/bin/gsearch_highlight.py 2>/dev/null; then
        cp gsearch_highlight.py ~/.local/bin/gsearch_highlight.py
        chmod +x ~/.local/bin/gsearch_highlight.py
    fi

# Copy config to fish config file (idempotent)
copy-config:
    #!/bin/bash
    mkdir -p ~/.config/fish
    FISH_CONFIG=~/.config/fish/config.fish
    if [ -f "$FISH_CONFIG" ] && grep -q "# START_MANAGED_CONFIG" "$FISH_CONFIG"; then
        # Extract managed config from source
        NEW_CONFIG=$(sed -n '/# START_MANAGED_CONFIG/,/# END_MANAGED_CONFIG/p' config.fish)
        # Remove old managed section and append new one
        sed -i '/# START_MANAGED_CONFIG/,/# END_MANAGED_CONFIG/d' "$FISH_CONFIG"
        echo "$NEW_CONFIG" >> "$FISH_CONFIG"
        echo "Updated managed config section"
    else
        echo "Appending managed config..."
        cat config.fish >> "$FISH_CONFIG"
    fi


# Headset wh1000xm3 has 2 modes by default - with micro and one without it.
# Next setting switches modes automatically
fix-microphone:
  mkdir -p ~/.config/wireplumber/bluetooth.lua.d/
  cp 51-bluez-config.lua ~/.config/wireplumber/bluetooth.lua.d/
