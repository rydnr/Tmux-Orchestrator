# Agent Communication Protocol

## MANDATORY: All Agents Must Report to PM

**Critical Rule**: All agents MUST communicate with the PM, not to stdout/console.

## Why This Matters
- Prevents agents from being idle
- Ensures proper coordination
- Maintains clear communication flow
- PM can track progress and blockers

## How to Communicate

### For Regular Agents (Alex, Eva, Quinn, Sam, Dana)
```bash
# Always use this format to report to PM:
./tmux-orchestrator/send-claude-message.sh semantest:0 "@PM: Your update here"

# Examples:
./tmux-orchestrator/send-claude-message.sh semantest:0 "@PM: Starting work on WebSocket integration"
./tmux-orchestrator/send-claude-message.sh semantest:0 "@PM: Completed test suite for image download"
./tmux-orchestrator/send-claude-message.sh semantest:0 "@PM: BLOCKED - need GPG key setup"
```

### For PM
```bash
# To message specific agents:
./tmux-orchestrator/send-claude-message.sh semantest:1 "@Alex: Please implement the queue system"
./tmux-orchestrator/send-claude-message.sh semantest:2 "@Eva: Update the UI for folder selection"
./tmux-orchestrator/send-claude-message.sh semantest:3 "@Quinn: Test the complete flow"
```

## Communication Flow
```
Agents → PM → Orchestrator/rydnr
   ↑      ↓
   ←------←
```

## What NOT to Do
❌ Don't use `echo` or `console.log` for status updates
❌ Don't work silently without reporting progress
❌ Don't wait idle - always report your status to PM

## What TO Do
✅ Report when starting a task
✅ Report progress updates
✅ Report completion
✅ Report blockers immediately
✅ Ask PM for clarification when needed

## Remember
- PM is always in window 0
- Use send-claude-message.sh for ALL communications
- Include "@PM:" prefix in your messages
- Be clear and concise in updates