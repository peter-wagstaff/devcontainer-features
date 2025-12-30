# Agent Credentials

Persist coding agent credentials (Claude Code and Codex) across dev container rebuilds.

## Usage

Add to VS Code User Settings (`settings.json`):

```json
{
  "dev.containers.defaultFeatures": {
    "ghcr.io/fjktkm/devcontainer-features/agent-creds:1": {}
  }
}
```

## How It Works

- Creates Docker volumes for each agent
- Symlinks `~/.claude` and `~/.codex` to volumes
- Credentials persist across container rebuilds

## Troubleshooting

Check symlinks:
```bash
ls -la ~/.claude ~/.codex
```

Reset credentials:
```bash
docker volume rm claude-creds codex-creds
```
