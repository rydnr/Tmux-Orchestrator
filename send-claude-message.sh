#!/usr/bin/env bash

# Send message to Claude agent in tmux window
# Usage: send-claude-message.sh <session:window> <message>
# Now includes automatic Claude health check and restart

if [ $# -lt 2 ]; then
    echo "Usage: $0 <session:window> <message>"
    echo "Example: $0 agentic-seek:3 'Hello Claude!'"
    exit 1
fi

WINDOW="$1"
shift # Remove first argument, rest is the message
MESSAGE="$*"

# Source the health check functions if available
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/claude-health-check.sh" ]; then
    source "$SCRIPT_DIR/claude-health-check.sh"
    
    # Ensure Claude is running before sending message
    ensure_claude_running "$WINDOW"
fi

# Send the message
tmux send-keys -t "$WINDOW" "$MESSAGE"

# Wait 0.5 seconds for UI to register
sleep 0.5

# Send Enter to submit
tmux send-keys -t "$WINDOW" Enter

echo "Message sent to $WINDOW: $MESSAGE"
