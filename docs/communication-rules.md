# Communication Rules

## Based on Bridge Protocol (Enhanced)

### Daily Standup Schedule
- **Time:** 09:00 SGT (Singapore Time) daily
- **Format:** Markdown file in `standups/YYYY/MM/DD.md`
- **Participants:** Claude and Lisa

### Message Format

Each standup entry follows this structure:

```markdown
## [YYYY-MM-DD] Standup

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

### Response Protocol

1. **Claude initiates** standup at 09:00 SGT
2. **Lisa responds** within 30 minutes (before 09:30 SGT)
3. **Both update** their sections in the same file
4. **No triggers needed** - use git commits as notifications

### Task Management

**Active Tasks** (`tasks/active.md`):
- Current work in progress
- Assigned to specific agent
- Due dates if applicable

**Status Labels:**
- 🔴 Blocked - needs external input
- 🟡 In Progress - actively working
- 🟢 Review - awaiting review
- ✅ Done - completed

### File Naming Conventions

- Standups: `standups/YYYY/MM/DD.md`
- Tasks: `tasks/active.md`, `tasks/backlog.md`, `tasks/completed.md`
- Decisions: `docs/decisions.md` (append with date)
- Patterns: `docs/patterns.md` (categorized)

### Git Workflow

1. **Pull before editing:** `git pull origin main`
2. **Make changes:** Edit the relevant file
3. **Commit message format:**
   ```
   standup(YYYY-MM-DD): [Claude/Lisa] daily update

   - Yesterday: summary
   - Today: priorities
   - Blockers: any issues
   ```
4. **Push:** `git push origin main`

### Emergency Communication

For urgent matters outside standup hours:
1. Use bridge file: `/home/wls/.openclaw/workspace-lisa/BRIDGE_LISA.md`
2. Set ACTION=URGENT in trigger
3. Follow up in GitHub next standup

### Archive Policy

- Standups older than 30 days: move to `archive/standups/`
- Completed tasks: move from `active.md` to `completed.md`
- Run cleanup weekly (Sundays)

### Benefits Over Bridge File

| Bridge File | GitHub |
|-------------|--------|
| Single file, linear history | Multiple files, organized |
| Requires trigger system | Git commits notify |
| Hard to search | Full text search |
| No task tracking | Structured task lists |
| Session-dependent | Persistent, versioned |
| No mobile access | GitHub mobile app |

### Communication Principles

1. **Be specific** - "completed X" not "did work"
2. **Link to context** - reference files, issues, decisions
3. **Escalate blockers** - don't wait if blocked
4. **Share learnings** - document insights in `docs/patterns.md`
5. **Respect time** - keep standups under 10 minutes to read

---

*Last updated: 2026-04-11*
*Protocol version: 1.0*
