#!/bin/sh
set -e

echo "Activating feature 'agent-creds'"

# Resolve the intended remote user (feature scripts run as root)
TARGET_USER="${_REMOTE_USER:-${_CONTAINER_USER:-}}"
[ -z "$TARGET_USER" ] && TARGET_USER="$(stat -c %U /workspaces 2>/dev/null || true)"
[ -z "$TARGET_USER" ] && TARGET_USER="${SUDO_USER:-root}"

TARGET_HOME="$(getent passwd "$TARGET_USER" 2>/dev/null | cut -d: -f6)"
TARGET_HOME="${TARGET_HOME:-$(eval echo "~$TARGET_USER" 2>/dev/null)}"
HOME="${TARGET_HOME:-/root}"

# Setup symlink from volume mount to home directory
setup_symlink() {
    mkdir -p "$1"
    mkdir -p "$(dirname "$HOME/$2")"
    [ -e "$HOME/$2" ] && [ ! -L "$HOME/$2" ] && rm -rf "$HOME/$2"
    ln -sf "$1" "$HOME/$2"
    chmod -R 777 "$1" 2>/dev/null || true
}

# Setup all agent credential directories
setup_symlink "/mnt/claude" ".claude"
setup_symlink "/mnt/codex" ".codex"
setup_symlink "/mnt/gemini" ".gemini"
setup_symlink "/mnt/cache-google-vscode-extension" ".cache/google-vscode-extension"
setup_symlink "/mnt/cache-cloud-code" ".cache/cloud-code"

echo "Done. Supported: Claude Code, Codex, Gemini Code Assist"
