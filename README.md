# claude-skills

336 Claude Code skills, kept here so cloud sessions can restore them on startup.

Cloud session containers are ephemeral — anything installed into `~/.claude/skills/`
is gone when the container is reclaimed. This repo is the durable copy; a
`SessionStart` hook in each project repo pulls it in automatically.

## Install by hand

```bash
git clone https://github.com/ErrickEagle/claude-skills
./claude-skills/install.sh
```

Existing skills of the same name are left alone. Pass `--force` to overwrite them.

## Wire a project repo to restore these automatically

In the project repo, add `.claude/hooks/session-start.sh` (see
`examples/session-start.sh` here) and register it in `.claude/settings.json`.
Every cloud session on that repo then starts with all 336 skills available.

For a **private** skills repo, the session's git proxy only serves repositories
attached to that session — so select both the project repo and this one when
starting a session, or the clone step is skipped and the hook exits quietly.

## What's in here

See `MANIFEST.md` for the full list grouped by source bundle, plus licensing.

Skills only. The source bundles for `claude-mem`, `impeccable` and `superpowers`
also shipped hooks that run code automatically; those were deliberately left out.
