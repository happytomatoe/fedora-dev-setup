#!/usr/bin/env bash
set -euo pipefail

FONTS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
mkdir -p "$FONTS_DIR"
UPDATED=false

JETBRAINS_MARKER="$FONTS_DIR/JetBrainsMonoNerdFont-Regular.ttf"
if [ -f "$JETBRAINS_MARKER" ]; then
    echo "==> JetBrains Mono Nerd Font already installed, skipping..."
else
    echo "==> Installing JetBrains Mono Nerd Font..."
    curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz" \
      -o /tmp/JetBrainsMono.tar.xz
    tar -xf /tmp/JetBrainsMono.tar.xz -C "$FONTS_DIR"
    rm /tmp/JetBrainsMono.tar.xz
    UPDATED=true
fi

NOTO_EMOJI="$FONTS_DIR/NotoColorEmoji.ttf"
if [ -f "$NOTO_EMOJI" ]; then
    echo "==> Noto Color Emoji already installed, skipping..."
else
    echo "==> Installing Noto Color Emoji (bitmap) for browser color emoji support..."
    curl -sL "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf" \
      -o "$NOTO_EMOJI"
    UPDATED=true
fi

if [ "$UPDATED" = true ]; then
    echo "==> Updating font cache..."
    fc-cache -fv "$FONTS_DIR"
    echo ""
    echo "Done! JetBrains Mono Nerd Font and Noto Color Emoji installed."
    echo "Restart your browser (Brave/Chrome) to pick up the new fonts."
else
    echo "==> All fonts already up to date."
fi
