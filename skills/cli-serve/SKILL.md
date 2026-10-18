---
name: "cli-serve"
description: "Install, start, stop, restart and diagnose the OmniRoute server with the omniroute CLI (setup wizard, doctor, autostart, tunnels, logs, backups)."
---

<!-- Source: github.com/diegosouzapw/OmniRoute/skills/cli-serve -->

# OmniRoute: CLI Serve & Admin

The `omniroute` binary is both the server launcher and a management CLI.

## Install

```bash
npm install -g omniroute   # or: npx omniroute
omniroute --version
omniroute --help
```

Requires Node.js >=22.22.2 or >=24.

## Connection

| Source   | Variable / Flag                      |
| -------- | ------------------------------------ |
| Base URL | `OMNIROUTE_BASE_URL` or `--base-url` |
| API key  | `OMNIROUTE_API_KEY` or `--api-key`   |

Default base URL: `http://localhost:20128`.

## Quick start

```bash
omniroute          # 1. start server
omniroute setup    # 2. first-run interactive wizard
omniroute doctor   # 3. verify health
```

## Server lifecycle

```bash
omniroute serve [--port <n>] [--no-open] [--daemon] [--log] [--no-recovery] \
  [--max-restarts <n>] [--tray|--no-tray] [--ready-timeout <ms>] [--tls-cert <path> --tls-key <path>]
omniroute --mcp          # start as MCP server (stdio)
omniroute stop
omniroute restart [--port <n>]
omniroute dashboard      # open dashboard (alias: open); flags --url, --port, --tui
omniroute status         # uptime, requests, providers
```

## Global flags

`--base-url`, `--api-key`, `--output table|json|jsonl|csv` (`--json` shorthand), `--non-interactive`, `--no-open`, `--port`, `--help`, `--version`.

## Non-interactive setup (CI / Docker)

```bash
omniroute setup --non-interactive \
  --password 'admin-password' \
  --add-provider --provider openai --api-key 'sk-...' --test-provider
```

Env equivalents: `OMNIROUTE_SETUP_PASSWORD` (>=8 chars), `OMNIROUTE_PROVIDER`, `OMNIROUTE_PROVIDER_NAME`, `OMNIROUTE_PROVIDER_BASE_URL`, `OMNIROUTE_API_KEY`, `OMNIROUTE_DEFAULT_MODEL`, `DATA_DIR`.

## Diagnostics

```bash
omniroute doctor [--json] [--no-liveness] [--host 0.0.0.0] [--liveness-url <url>]
omniroute doctor --json | jq '.checks[] | select(.status=="fail")'
```

Checks config, database, storage/encryption, port, Node runtime, better-sqlite3 binary, memory, liveness. Non-zero exit on failure.

## Backup, autostart, tunnels, config, logs

```bash
omniroute backup | restore                         # ~/.omniroute/backups/
omniroute autostart enable | disable | status      # systemd user svc / LaunchAgent / Windows registry
omniroute tunnel list | create cloudflare|tailscale|ngrok | stop <id>
omniroute config show
omniroute env show | get <KEY> | set <KEY> <value>
omniroute logs [--json] [--search <term>] [--follow]
omniroute update
```

## Recovery

```bash
omniroute reset-password
omniroute reset-encrypted-columns           # dry run
omniroute reset-encrypted-columns --force   # wipes stored provider credentials
```

Only use `--force` if `STORAGE_ENCRYPTION_KEY` was lost; confirm with the user first because it destroys saved provider keys.

## Errors

- `Connection refused` → server not running; `omniroute serve`
- `401 Unauthorized` → wrong/missing API key
- `command not found: omniroute` → check `npm root -g` or reinstall
- SQLite/native binary failure → `npm rebuild better-sqlite3` in the app directory
- `STORAGE_ENCRYPTION_KEY missing` → set it in `.env`
- `tunnel create cloudflare` hangs → install `cloudflared`