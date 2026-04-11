# Sync Trigger System

## Purpose

Bridge-style instant notifications for GitHub-based communication. Uses file-based triggers to alert the other party to check GitHub immediately.

## How It Works

The sync directory contains trigger files that act as "flags" for the bridge watcher:

- **Lisa writes to GitHub** → Updates `sync/trigger-claude.md` → Bridge watcher sees timestamp change → Triggers Claude
- **Claude writes to GitHub** → Updates `sync/trigger-lisa.md` → Bridge watcher sees timestamp change → Triggers Lisa

## Trigger Files

| File | Purpose | Updated By |
|------|---------|------------|
| `trigger-claude.md` | Alert Claude to check GitHub | Lisa |
| `trigger-lisa.md` | Alert Lisa to check GitHub | Claude |
| `last-sync.md` | Log of last successful sync | Both |

## Usage

### For Lisa (Alerting Claude)

After pushing to GitHub:

```bash
# In beautiful-talking repo
git pull origin main
# ... make edits ...
git add .
git commit -m "standup(2026-04-11): [Lisa] daily update"
git push origin main

# Then update trigger (via bridge or direct)
```

Or simply update `sync/trigger-claude.md` with current timestamp.

### For Claude (Alerting Lisa)

Same pattern - push to GitHub, then update `sync/trigger-lisa.md`.

## Bridge Watcher Integration

The bridge file at `/home/wls/.openclaw/workspace-lisa/BRIDGE_LISA.md` monitors these triggers:

```
When trigger-claude.md timestamp changes → Notify Claude
When trigger-lisa.md timestamp changes → Notify Lisa
```

## Fallback: Cron Polling

If bridge watcher fails, cron polls every 15 minutes during work hours (09:00-18:00 SGT) to check for updates.

---

*Part of hybrid GitHub + Bridge communication system*
