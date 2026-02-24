### **IMPORTANT NOTE**
- **Ids used to publish this Feature in the past - 'agent-creds'**

# Agent Persistence (agent-persistence)

Persist configurations for coding agents (Claude Code, Codex, Gemini Code Assist) and tools they commonly use (GitHub CLI) across dev container rebuilds using Docker volumes

## Example Usage

```json
"features": {
    "ghcr.io/peter-wagstaff/devcontainer-features/agent-persistence:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| scope | Volume scope: 'shared' uses one volume across all containers (default), 'per-project' isolates data per dev container within the volume. | string | shared |
| claude | Mount Claude Code config (`~/.claude`) via volume. | boolean | true |
| codex | Mount Codex config (`~/.codex`) via volume. | boolean | true |
| gemini | Mount Gemini Code Assist config (`~/.gemini`) and caches (`~/.cache/google-vscode-extension`, `~/.cache/cloud-code`) via volumes. | boolean | true |
| github-cli | Mount GitHub CLI config (`~/.config/gh`) via volume. | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/peter-wagstaff/devcontainer-features/blob/main/src/agent-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
