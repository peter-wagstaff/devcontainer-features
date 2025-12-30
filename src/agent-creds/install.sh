#!/bin/sh
set -e

echo "Activating feature 'agent-creds'"

# Get remote user information
USER="${_REMOTE_USER:-${_CONTAINER_USER:-root}}"
HOME="${_REMOTE_USER_HOME:-${_CONTAINER_USER_HOME:-/root}}"

# Setup symlink from volume mount to home directory
setup_symlink() {
    mkdir -p "$1"
    mkdir -p "$(dirname "$HOME/$2")"
    [ -e "$HOME/$2" ] && [ ! -L "$HOME/$2" ] && rm -rf "$HOME/$2"
    ln -sf "$1" "$HOME/$2"
    [ "$USER" != "root" ] && chown -R "$USER:$USER" "$1" 2>/dev/null || true
}

# Setup all agent credential directories
setup_symlink "/mnt/.claude" ".claude"
setup_symlink "/mnt/.codex" ".codex"

echo "Done. Supported: Claude Code, Codex"
