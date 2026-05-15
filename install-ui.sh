#!/bin/bash

# Prompt for sudo password once and keep it cached
sudo -v
while true; do
  sudo -v
  sleep 60
done &
SUDO_KEEPER_PID=$!
trap "kill $SUDO_KEEPER_PID 2>/dev/null; sudo -k" EXIT

set -x
#==============================================================================
# UI / GNOME settings
#==============================================================================

# disable animation effects
echo "Disabling animation effects..."
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter enable-animations false 2>/dev/null || true

# Alt+Number for app switching (instead of Super+Number)
echo "Setting Alt+Number for app switching..."
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "['<Alt>$i']"
done
for i in {1..10}; do
  gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "[]"
done

# Swap Caps Lock and Escape
echo "Swapping Caps Lock and Escape..."
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
