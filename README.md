# dotfiles

These are the dotfiles I use on macOS. When used _correctly_, it should look
something like

![shell gif](https://media.giphy.com/media/pyAYkeVFs0A2pzSaL6/giphy.gif)

`script/pihole-install.sh` installs pihole in a local Docker container and sets
the machine's DNS server to that container's process

`script/setup-macos.sh` is inspired from https://mths.be/macos to set macOS
system preferences to settings I enjoy

`script/bootstrap` is for Github codespaces to setup itself (https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles)

`script/ensure_machine_setup.sh` sets up a new macOS machine by installing
things like Xcode, Homebrew, rvm, and some {brew, brew cask}s

# Claude Code config

`claude/` holds the shared Claude Code config — `settings.json`, `CLAUDE.md`,
`agents/`, `commands/`, `skills/`, `hooks/`. `script/link-claude` symlinks each
of those into `~/.claude/`, and `script/copy-shared` calls it, so a normal
`copy-macos` / `copy-ubuntu` run sets it up.

This subtree is **symlinked rather than copied**, unlike everything else here.
Claude Code edits these files in place — `/config` rewrites `settings.json`, and
agents get hand-edited — so copying would lose those edits on the next
`copy-shared`. With symlinks, an edit made on any machine shows up in
`git status` here, which is what makes the Mac ↔ VPS round trip work. The
tradeoff: the repo has to stay put, and moving the clone means re-running
`script/link-claude`.

Git is the transport, not mackup/iCloud — the Linux boxes can't see iCloud
Drive, and two sync systems owning the same path is how you get conflicts.
`~/.claude` is deliberately absent from `mackup/andrews-nonstandard-dotfiles.cfg`
for that reason.

To move changes between machines:

```
script/claude-sync          # commit claude/ edits, pull --rebase, push
script/claude-sync pull     # just pick up the other machine's edits
script/claude-sync doctor   # check the symlinks are intact, re-link if not
```

`doctor` exists because Claude Code rewrites `settings.json` when a setting
changes; if it ever does that via temp-file-and-rename it will replace the
symlink with a regular file and the sync silently stops. `doctor` catches that
and re-links (backing up the real file first).

## What is not synced

Only the allowlist in `script/link-claude` is linked. The rest of `~/.claude`
stays local and must not be committed:

- `.credentials.json`, `~/.claude.json` — secrets and machine identity
  (`machineID`, `userID`, `oauthAccount`), plus per-project history
- `settings.local.json` — the place for machine-specific hooks and permissions
- `projects/`, `sessions/`, `session-env/`, `shell-snapshots/`, `history.jsonl`,
  `backups/`, `cache/`, `paste-cache/` — local state
- `plugins/marketplaces/` — a checkout, re-fetched per machine

# `script/setup-macos.sh` TODO:

1. Hide menubar
2. Turn off iCloud mail
