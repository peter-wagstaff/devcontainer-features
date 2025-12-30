# Dev Container Features

A collection of dev container features for improving development workflow.

## `agent-auth`

Persist coding agent credentials (Claude Code and Codex) across dev container rebuilds using Docker volumes.

**Usage:** Add to VS Code User Settings (`settings.json`):

```json
{
  "dev.containers.defaultFeatures": {
    "ghcr.io/fjktkm/devcontainer-features/agent-auth:1": {}
  }
}
```

See [src/agent-auth/README.md](src/agent-auth/README.md) for more details.
