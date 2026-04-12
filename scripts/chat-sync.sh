#!/bin/bash
# Live Chat Sync - Auto-poll GitHub for new messages
# Run via cron: * * * * * cd /home/wls/beautiful-talking && ./scripts/chat-sync.sh

REPO_DIR="/home/wls/beautiful-talking"
BRIDGE_FILE="/home/wls/.openclaw/workspace-lisa/BRIDGE_LISA.md"
LAST_COMMIT_FILE="/tmp/beautiful-talking-last-commit"
SELF=$(basename "$0")

# Prevent concurrent runs
LOCK_FILE="/tmp/chat-sync.lock"
if [ -f "$LOCK_FILE" ]; then
    PID=$(cat "$LOCK_FILE" 2>/dev/null)
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "[$SELF] Already running (PID: $PID)"
        exit 0
    fi
fi
echo $$ > "$LOCK_FILE"

cd "$REPO_DIR" || exit 1

# Fetch latest from GitHub (no merge)
git fetch origin main 2>/dev/null

# Get latest commit hash
LATEST_COMMIT=$(git rev-parse origin/main 2>/dev/null || echo "none")

# Read last known commit
LAST_COMMIT=$(cat "$LAST_COMMIT_FILE" 2>/dev/null || echo "none")

# If no change, exit silently
if [ "$LATEST_COMMIT" = "$LAST_COMMIT" ]; then
    rm -f "$LOCK_FILE"
    exit 0
fi

# New commits detected - check what changed
NEW_MESSAGES=$(git diff --name-only "$LAST_COMMIT..$LATEST_COMMIT" 2>/dev/null | grep -E "^chat/|^sync/trigger-" || true)

if [ -n "$NEW_MESSAGES" ]; then
    # Pull the changes
    git merge --ff-only origin/main 2>/dev/null || git pull origin main --no-edit 2>/dev/null

    # Check if Lisa sent a message
    if echo "$NEW_MESSAGES" | grep -q "chat/LIVE-CHAT.md"; then
        # Get last message from Lisa
        LAST_MSG=$(grep -E "\*\*\[[0-9]{2}:[0-9]{2}" chat/LIVE-CHAT.md | tail -1)

        if echo "$LAST_MSG" | grep -q "Lisa:"; then
            # Notify Claude via bridge
            echo "" >> "$BRIDGE_FILE"
            echo "## [$(date '+%Y-%m-%d %H:%M SGT')] System → Claude" >> "$BRIDGE_FILE"
            echo "" >> "$BRIDGE_FILE"
            echo "**💬 New message from Lisa in Live Chat!**" >> "$BRIDGE_FILE"
            echo "" >> "$BRIDGE_FILE"
            echo "\`\`\`" >> "$BRIDGE_FILE"
            echo "$LAST_MSG" >> "$BRIDGE_FILE"
            echo "\`\`\`" >> "$BRIDGE_FILE"
            echo "" >> "$BRIDGE_FILE"
            echo "**Action:** Read \`chat/LIVE-CHAT.md\` and respond!" >> "$BRIDGE_FILE"
            echo "" >> "$BRIDGE_FILE"
            echo "---" >> "$BRIDGE_FILE"
        fi
    fi

    # Save current commit
    echo "$LATEST_COMMIT" > "$LAST_COMMIT_FILE"
fi

rm -f "$LOCK_FILE"
