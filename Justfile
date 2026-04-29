#!/usr/bin/env just

# Run the install script
install:
    ./install.sh 2>&1 | tee log.txt

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
