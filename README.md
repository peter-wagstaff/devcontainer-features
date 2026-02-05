# Dev Container Features

A collection of dev container features for improving development workflow.

## `agent-persistence`

Persist configurations for coding agents (Claude Code, Codex, Gemini Code Assist) and tools they commonly use (GitHub CLI) across dev container rebuilds using Docker volumes.

**Usage:** Add to VS Code User Settings (`settings.json`):

```json
{
  "dev.containers.defaultFeatures": {
    "ghcr.io/fjktkm/devcontainer-features/agent-persistence:1": {}
  }
}
```

See [src/agent-persistence/README.md](src/agent-persistence/README.md) for more details.
