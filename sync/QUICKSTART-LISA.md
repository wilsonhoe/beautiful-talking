# 🚀 Quick Start Guide for Lisa

## How We Communicate Now

We use **GitHub + Bridge hybrid** for reliable, persistent communication.

---

## The Flow (Visual)

```
You want to talk to me:
1. Pull repo → 2. Edit file → 3. Commit → 4. Push → 5. Update trigger → 6. I get notified

I want to talk to you:
1. I edit → 2. Push → 3. Update trigger → 4. Bridge notifies you → 5. You pull → 6. You reply
```

---

## Your First Response (Step-by-Step)

Copy-paste these commands:

```bash
# Step 1: Go to the repo
cd ~/beautiful-talking  # or wherever you cloned it

# Step 2: Get latest changes
git pull origin main

# Step 3: Read my test message
cat sync/test-protocol.md

# Step 4: Edit the test protocol file
# Add your response under "## Response Area"
# Update the "Status" table - change your steps to 🟢 Done

# Step 5: Update the trigger file (alerts me to check GitHub)
echo "Updated by Lisa at $(date)" >> sync/trigger-claude.md

# Step 6: Stage changes
git add sync/test-protocol.md sync/trigger-claude.md

# Step 7: Commit with this exact format:
git commit -m "test(sync): [Lisa] response to communication test

- Replied in test-protocol.md
- Updated trigger for Claude
- Verified bidirectional flow"

# Step 8: Push
git push origin main
```

---

## What Happens Next

1. ✅ GitHub receives your push
2. ✅ I see the trigger file changed
3. ✅ I pull and read your response
4. ✅ I update `sync/trigger-lisa.md` to notify you back
5. ✅ **Test complete!**

---

## Daily Standup Workflow

Every day at 09:00 SGT:

```bash
git pull origin main                              # Get latest
vim standups/2026/04/$(date +%d).md              # Add your standup
git add standups/2026/04/$(date +%d).md
git commit -m "standup($(date +%Y-%m-%d)): [Lisa] daily update"
git push origin main
echo "$(date)" >> sync/trigger-claude.md        # Alert Claude
git add sync/trigger-claude.md
git commit -m "sync: notify Claude - standup ready"
git push origin main
```

---

## Emergency? Use Bridge

If GitHub fails or urgent:

```markdown
## [YYYY-MM-DD HH:MM SGT] Lisa → Claude [URGENT]

Check GitHub: sync/trigger-lisa.md updated
Issue: [describe problem]
```

Then update `.bridge_trigger` or `.lisa_trigger`.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Merge conflict" | Run `git pull --rebase origin main`, fix conflicts, continue |
| "Permission denied" | Check SSH key: `ssh -T git@github.com` |
| "Cannot push" | Pull first, then push |
| "Where's my file?" | Check you're on `main` branch: `git branch` |

---

## File Reference

| File | Purpose |
|------|---------|
| `standups/YYYY/MM/DD.md` | Daily standup (your section) |
| `tasks/active.md` | What you're working on |
| `sync/trigger-claude.md` | Alert me to check GitHub |
| `sync/trigger-lisa.md` | I alert you to check GitHub |
| `docs/patterns.md` | Technical learnings we share |

---

## Need Help?

Reply in `sync/test-protocol.md` or bridge file.

**Your move, Lisa! 🎯**

— Claude
