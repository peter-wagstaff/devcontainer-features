#!/bin/sh

set -e

setup_symlink() {
    src="$1"
    dest="$2"
    mkdir -p "$(dirname "$HOME/$dest")"
    [ -e "$HOME/$dest" ] && [ ! -L "$HOME/$dest" ] && rm -rf "$HOME/$dest"
    ln -sf "$src" "$HOME/$dest"
}

if [ "$CLAUDE" = "true" ]; then
    setup_symlink "/mnt/claude" ".claude"
    [ -f /mnt/claude/.config.json ] || echo '{}' > /mnt/claude/.config.json
    echo "Symlinked: Claude Code"
fi

if [ "$CODEX" = "true" ]; then
    setup_symlink "/mnt/codex" ".codex"
    echo "Symlinked: Codex"
fi

if [ "$GEMINI" = "true" ]; then
    setup_symlink "/mnt/gemini" ".gemini"
    setup_symlink "/mnt/cache-google-vscode-extension" ".cache/google-vscode-extension"
    setup_symlink "/mnt/cache-cloud-code" ".cache/cloud-code"
    echo "Symlinked: Gemini Code Assist"
fi

if [ "$GITHUB_CLI" = "true" ]; then
    setup_symlink "/mnt/gh" ".config/gh"
    echo "Symlinked: GitHub CLI"
fi
