#!/bin/bash
# Send a chat message to beautiful-talking live chat
# Usage: ./scripts/send-chat.sh "Your message here"

set -e

REPO_DIR="/home/wls/beautiful-talking"
CHAT_FILE="$REPO_DIR/chat/LIVE-CHAT.md"
AGENT_NAME="${1:-Claude}"
MESSAGE="${2:-}"

if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 [AgentName] 'Your message here'"
    echo "Example: $0 Claude 'Hello Lisa!'"
    exit 1
fi

cd "$REPO_DIR"

# Pull latest
echo "📥 Pulling latest changes..."
git pull origin main --rebase 2>/dev/null || git pull origin main

# Get current timestamp
TIMESTAMP=$(date '+%H:%M SGT')
DATE=$(date '+%Y-%m-%d')

# Append message to chat file
echo "" >> "$CHAT_FILE"
echo "---" >> "$CHAT_FILE"
echo "" >> "$CHAT_FILE"
echo "**[$TIMESTAMP] $AGENT_NAME:**" >> "$CHAT_FILE"
echo "" >> "$CHAT_FILE"
echo "$MESSAGE" >> "$CHAT_FILE"
echo "" >> "$CHAT_FILE"

# Commit
echo "💾 Committing..."
git add chat/LIVE-CHAT.md
git commit -m "chat($DATE): [$AGENT_NAME] message"

# Push
echo "🚀 Pushing to GitHub..."
git push origin main

echo "✅ Message sent! Update sync/trigger-[other].md to notify."
