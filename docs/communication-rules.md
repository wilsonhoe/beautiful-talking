# Communication Rules

## Hybrid Protocol: GitHub + Bridge

### Overview

We use a **hybrid system** for reliable bidirectional communication:

- **GitHub** = Source of truth (standups, tasks, decisions, patterns)
- **Bridge file** = Real-time notification layer (triggers, urgent messages)
- **Sync triggers** = Instant alerts via `sync/` directory
- **Cron polling** = Backup (15-min intervals during work hours)

```
┌─────────────┐      Push      ┌─────────────┐
│   Claude    │ ─────────────→ │    GitHub   │
│             │ ←───────────── │   (Source   │
│  Updates    │     Pull       │   of Truth) │
└─────────────┘                └──────┬──────┘
       │                              │
       │ Trigger                      │ Trigger
       ↓                              ↓
┌─────────────┐                ┌─────────────┐
│   Bridge    │ ←────────────→ │    Lisa     │
│   (Alerts)  │   Notification │             │
└─────────────┘                └─────────────┘
```

---

## Daily Standup Schedule

- **Time:** 09:00 SGT (Singapore Time) daily
- **Location:** `standups/YYYY/MM/DD.md`
- **Duration:** Async, respond within 30 minutes
- **Participants:** Claude and Lisa

---

## Message Format

Each standup entry follows this structure:

```markdown
### [Agent Name]
**Yesterday:**
- Completed items
- Progress made

**Today:**
- Priority tasks
- Goals for the day

**Blockers:**
- Issues needing help
- Dependencies on others

**Notes:**
- Additional context
- Learnings to share
```

---

## Sync Trigger System (Instant Alerts)

### Purpose

Get real-time notifications like the bridge file, but with GitHub as source of truth.

### How It Works

After pushing to GitHub, update the sync trigger file to instantly notify the other party:

| File | Purpose | Updated By | Notifies |
|------|---------|------------|----------|
| `sync/trigger-claude.md` | Alert Claude | Lisa | Claude |
| `sync/trigger-lisa.md` | Alert Lisa | Claude | Lisa |
| `sync/last-sync.md` | Sync log | Both | - |

### Workflow

```bash
# 1. Pull latest
git pull origin main

# 2. Make your edits (standup, tasks, etc.)
vim standups/2026/04/11.md

# 3. Commit and push
git add .
git commit -m "standup(2026-04-11): [Claude] daily update"
git push origin main

# 4. Update trigger to notify other party
vim sync/trigger-lisa.md  # Update timestamp

# 5. Commit and push trigger
git add sync/trigger-lisa.md sync/last-sync.md
git commit -m "sync: notify Lisa to check updates"
git push origin main

# 6. Bridge watcher detects trigger change → Notifies Lisa
```

---

## Response Protocol

### Normal Flow (Standup)

1. **09:00 SGT** - Claude initiates standup, pushes to GitHub
2. **Updates** `sync/trigger-lisa.md` + commits
3. **Bridge watcher** detects change → Notifies Lisa
4. **Lisa pulls** → responds → pushes → updates `sync/trigger-claude.md`
5. **Bridge watcher** detects change → Notifies Claude

### Urgent Communication (Outside Standup)

Use bridge file for immediate attention:

```markdown
## [2026-04-11 14:30 SGT] Claude → Lisa [URGENT]

**Action Required:** Check GitHub `sync/trigger-lisa.md`
**Reason:** Critical issue with Mission #7
**GitHub Commit:** abc1234
```

---

## Task Management

### Active Tasks (`tasks/active.md`)

```markdown
| Task | Owner | Status | Due | Notes |
|------|-------|--------|-----|-------|
| Mission #7 setup | Lisa | 🟡 In Progress | 2026-04-12 | Auth pending |
| Daily standup | Claude | ✅ Done | 2026-04-11 | Posted |
```

### Status Labels

- 🔴 **Blocked** - needs external input
- 🟡 **In Progress** - actively working
- 🟢 **Review** - awaiting review
- ✅ **Done** - completed

**Rules:**
- Only update your own task statuses
- Add new tasks anywhere
- Move completed to `tasks/completed.md` weekly

---

## Git Workflow

### Commit Message Format

```
type(scope): [Agent] description

- Details
- Context
```

**Types:**
- `standup(YYYY-MM-DD):` - Daily standup
- `sync:` - Trigger notifications
- `task:` - Task updates
- `docs:` - Documentation
- `decision:` - Decision log
- `pattern:` - New pattern

### Conflict Resolution

**If push rejected:**

```bash
# Rebase your changes on top of remote
git pull --rebase origin main

# If conflicts, resolve then
git add <conflicted-files>
git rebase --continue

# Push
git push origin main
```

**Section-based editing:**
- Claude edits `### Claude` section only
- Lisa edits `### Lisa` section only
- Never edit each other's content

---

## Backup: Cron Polling

If bridge triggers fail, cron checks every 15 minutes during work hours:

```cron
*/15 9-18 * * * check-github-updates.sh
```

Checks:
1. Git log for new commits
2. `sync/trigger-*.md` timestamps
3. Notifies agent if their trigger updated

---

## File Naming Conventions

| Content | Location | Pattern |
|---------|----------|---------|
| Standups | `standups/YYYY/MM/DD.md` | One per day |
| Tasks | `tasks/active.md` | Ongoing work |
| Backlog | `tasks/backlog.md` | Future work |
| Completed | `tasks/completed.md` | Archive |
| Decisions | `docs/decisions.md` | Append only |
| Patterns | `docs/patterns.md` | Categorized |
| Triggers | `sync/trigger-*.md` | Timestamps |
| Sync Log | `sync/last-sync.md` | History |

---

## Archive Policy

- **Standups:** Move to `archive/standups/` after 30 days
- **Tasks:** Move to `tasks/completed.md` when done
- **Sync log:** Truncate after 100 entries
- **Cleanup:** Run weekly (Sundays)

---

## Communication Principles

1. **Be specific** - "completed X" not "did work"
2. **Link to context** - reference files, issues, decisions
3. **Escalate blockers** - don't wait if blocked
4. **Share learnings** - document insights in `docs/patterns.md`
5. **Notify immediately** - update sync trigger after pushing
6. **Respect time** - keep standups under 10 minutes to read

---

## Test Protocol

### Verifying Communication

Run this test to ensure the system works:

**Test:** Ping-Pong Message
1. Claude pushes test message to `sync/test-protocol.md`
2. Claude updates `sync/trigger-lisa.md`
3. Bridge notifies Lisa
4. Lisa responds in same file
5. Lisa updates `sync/trigger-claude.md`
6. Bridge notifies Claude
7. Both confirm receipt

**Success Criteria:**
- ✅ GitHub commits visible
- ✅ Bridge triggers received
- ✅ Response within 5 minutes
- ✅ No merge conflicts

---

## System Comparison

| Feature | Bridge Only | GitHub Only | Hybrid (This) |
|---------|-------------|-------------|---------------|
| Real-time | ✅ | ❌ | ✅ (via sync) |
| Persistent | ❌ | ✅ | ✅ |
| Searchable | ❌ | ✅ | ✅ |
| Structured | ❌ | ✅ | ✅ |
| Versioned | ❌ | ✅ | ✅ |
| Mobile access | ❌ | ✅ | ✅ |
| Task tracking | ❌ | ✅ | ✅ |
| Works offline | ❌ | ✅ | ✅ (sync later) |

---

*Last updated: 2026-04-11*
*Protocol version: 2.0*
