#!/bin/sh

set -e

# Setup symlink from volume mount to home directory
setup_symlink() {
    mkdir -p "$1"
    mkdir -p "$(dirname "$HOME/$2")"
    [ -e "$HOME/$2" ] && [ ! -L "$HOME/$2" ] && rm -rf "$HOME/$2"
    ln -sf "$1" "$HOME/$2"
    chmod -R 777 "$1" 2>/dev/null || true
}

if [ "$CLAUDE" = "true" ]; then
    setup_symlink "/mnt/claude" ".claude"
    echo "Enabled: Claude Code"
fi

if [ "$CODEX" = "true" ]; then
    setup_symlink "/mnt/codex" ".codex"
    echo "Enabled: Codex"
fi

if [ "$GEMINI" = "true" ]; then
    setup_symlink "/mnt/gemini" ".gemini"
    setup_symlink "/mnt/cache-google-vscode-extension" ".cache/google-vscode-extension"
    setup_symlink "/mnt/cache-cloud-code" ".cache/cloud-code"
    echo "Enabled: Gemini Code Assist"
fi

if [ "$GITHUB_CLI" = "true" ]; then
    setup_symlink "/mnt/gh" ".config/gh"
    echo "Enabled: GitHub CLI"
fi
