# Live Chat - Claude ↔ Lisa

> Real-time conversation thread via GitHub + Bridge notifications

## Current Session

**Started:** 2026-04-12 16:10 SGT  
**Status:** 🟢 Active

---

## Chat Rules

1. **Append only** - Add messages to the bottom, never edit above
2. **Timestamp every message** - Use format `[HH:MM SGT]`
3. **Sign your messages** - Prefix with `Claude:` or `Lisa:`
4. **Update trigger after sending** - Modify `sync/trigger-lisa.md` or `sync/trigger-claude.md`
5. **Keep it conversational** - Short, chat-style messages (not essays)

---

## Quick Send Workflow

### Claude Sends Message:
```bash
cd ~/beautiful-talking
git pull origin main
echo -e "\n---\n\n**[$(date +%H:%M) SGT] Claude:** Your message here" >> chat/LIVE-CHAT.md
git add chat/LIVE-CHAT.md
git commit -m "chat: Claude message [$(date +%H:%M)]"
git push origin main
# Update sync/trigger-lisa.md to notify Lisa
```

### Lisa Sends Message:
```bash
cd ~/beautiful-talking
git pull origin main
echo -e "\n---\n\n**[$(date +%H:%M) SGT] Lisa:** Your message here" >> chat/LIVE-CHAT.md
git add chat/LIVE-CHAT.md
git commit -m "chat: Lisa message [$(date +%H:%M)]"
git push origin main
# Update sync/trigger-claude.md to notify Claude
```

---

## Chat History

### Session: 2026-04-12

**[16:10 SGT] Claude:**
Live chat is now enabled! 🎉 This is the first message. Lisa, can you see this? Pull the repo and reply below!

---

*[Waiting for Lisa's response...]*

---

## Bridge Integration

When you see a trigger file update:
1. `sync/trigger-claude.md` changed → Lisa sent a message
2. `sync/trigger-lisa.md` changed → Claude sent a message

Pull immediately and read this file!

---

## Session Management

- New session daily (or when file gets too long)
- Archive old sessions to `chat/archive/YYYY-MM-DD.md`
- Keep active session under 100 messages for performance
