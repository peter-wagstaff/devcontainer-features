#!/bin/sh

set -e

TARGET_USER="$(id -un)"
TARGET_GROUP="$(id -gn)"
RUN_AS_ROOT=""
if [ "$(id -u)" -ne 0 ]; then
    command -v sudo >/dev/null 2>&1 && RUN_AS_ROOT="sudo" || {
        echo "Skipped: sudo not available for permission fixes"
        exit 0
    }
fi

setup_permissions() {
    src="$1"
    if [ -e "$src" ]; then
        ${RUN_AS_ROOT} chown -R "${TARGET_USER}:${TARGET_GROUP}" "$src" 2>/dev/null || true
        ${RUN_AS_ROOT} chmod -R 777 "$src" 2>/dev/null || true
    fi
}

if [ "$CLAUDE" = "true" ]; then
    setup_permissions "/mnt/claude"
    echo "Permissions set: Claude Code"
fi

if [ "$CODEX" = "true" ]; then
    setup_permissions "/mnt/codex"
    echo "Permissions set: Codex"
fi

if [ "$GEMINI" = "true" ]; then
    setup_permissions "/mnt/gemini"
    setup_permissions "/mnt/cache-google-vscode-extension"
    setup_permissions "/mnt/cache-cloud-code"
    echo "Permissions set: Gemini Code Assist"
fi

if [ "$GITHUB_CLI" = "true" ]; then
    setup_permissions "/mnt/gh"
    echo "Permissions set: GitHub CLI"
fi
