#!/bin/sh

CLAUDE="${CLAUDE:-true}"
CODEX="${CODEX:-true}"
GEMINI="${GEMINI:-true}"
GITHUB_CLI="${GITHUB_CLI:-true}"

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Script must be run as root."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
USER_SCRIPT="${SCRIPT_DIR}/scripts/install-user.sh"

# Determine the appropriate non-root user (mirrors github-cli feature behavior)
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS="vscode node codespace $(awk -v val=1000 -F ':' '$3==val{print $1}' /etc/passwd)"
    for CURRENT_USER in ${POSSIBLE_USERS}; do
        if [ -n "${CURRENT_USER}" ] && id -u "${CURRENT_USER}" > /dev/null 2>&1; then
            USERNAME="${CURRENT_USER}"
            break
        fi
    done
    if [ -z "${USERNAME}" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" > /dev/null 2>&1; then
    USERNAME=root
fi

if [ "${USERNAME}" = "root" ]; then
    CLAUDE="${CLAUDE}" CODEX="${CODEX}" GEMINI="${GEMINI}" GITHUB_CLI="${GITHUB_CLI}" \
        sh "${USER_SCRIPT}"
else
    su - "${USERNAME}" -c "CLAUDE=${CLAUDE} CODEX=${CODEX} GEMINI=${GEMINI} GITHUB_CLI=${GITHUB_CLI} sh '${USER_SCRIPT}'"
fi
