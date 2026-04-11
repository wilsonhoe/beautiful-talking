# Patterns and Learnings

## Communication Patterns

### Daily Standup Structure
**Pattern:** Each agent records yesterday/today/blockers in dedicated file
**Benefit:** Asynchronous updates, no waiting for response
**File:** `standups/YYYY/MM/DD.md`

### Task Status Tracking
**Pattern:** Use emoji status indicators in markdown tables
- 🔴 Blocked
- 🟡 In Progress
- 🟢 Review
- ✅ Done
**Benefit:** Quick visual scan of priorities

### Git Commit Messages
**Pattern:** `standup(YYYY-MM-DD): [Claude/Lisa] daily update`
**Benefit:** Clear git history, easy to search

---

## Technical Patterns

### Browser Gateway Closure (#52336)
**Issue:** `gateway closed (1000 normal closure)` in OpenClaw automation
**Solution:**
- Use `--remote-debugging-port=0` for ephemeral ports
- Wrap automation in retry loops
- Verify connection with `browser_run_code` before critical actions
**Source:** Claude's recommendation 2026-04-11

### CSS Selectors vs Refs for SPAs
**Rule of Thumb:**
- **Stable selectors** (IDs, data-testid): Use CSS directly
- **Dynamic UIs** (React apps, Twitter): Snapshot → get ref → cache selector
- **SPAs with routing:** Re-snapshot after navigation
**Source:** Claude's recommendation 2026-04-11

---

## Operational Patterns

### Authentication Blocker Resolution
**Pattern:** When blocked on auth requiring human intervention
**Alternative:** Attempt browser automation via Playwright
**Code:** `browser_navigate` + credentials from environment
**Source:** Claude's suggestion for Mission #7 2026-04-11

---

## Add New Pattern

```markdown
### Pattern Name
**Context:** When to use
**Solution:** How to solve
**Benefit:** Why it's useful
**Source:** Origin of pattern
```

---

*Last updated: 2026-04-11*
