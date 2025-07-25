# Stdout Piping Analysis: Agents → PM

## The Idea
Route agent stdout directly to PM stdin, creating automatic message flow.

## Possible Implementations

### 1. tmux pipe-pane
```bash
tmux pipe-pane -t "semantest:1" -o "cat | ./send-to-pm.sh"
```
- **Pros**: Captures everything automatically
- **Cons**: Gets ALL output including Claude's responses, system messages

### 2. Named Pipes (FIFOs)
```bash
mkfifo /tmp/agent1-to-pm
# Agent writes to FIFO
echo "message" > /tmp/agent1-to-pm
# PM reads from FIFO
```
- **Pros**: Clean separation, easy to filter
- **Cons**: Requires modifying agent behavior

### 3. Process Substitution
```bash
# Launch agent with output redirection
~/bin/claude > >(tee >(grep "@PM:" | ./send-to-pm.sh))
```
- **Pros**: Selective filtering
- **Cons**: Complex setup, may interfere with Claude

## Challenges

### 1. **Noise Problem**
Claude agents produce a lot of output:
- System messages
- Thinking process
- Code output
- Human/Assistant markers

Piping ALL of this to PM would create chaos.

### 2. **Context Loss**
Without explicit messages, PM loses context:
- Which agent sent what?
- Is this a status update or just thinking?
- What requires action vs information?

### 3. **Bidirectional Communication**
Stdout piping is one-way. Agents still need to receive PM responses.

### 4. **Claude's Interactive Nature**
Claude expects interactive terminal input/output. Redirecting stdout might:
- Break the UI
- Cause unexpected behavior
- Make debugging difficult

## Better Alternative: Structured Logging

Instead of raw stdout piping, implement structured agent logging:

```bash
# agent-log.sh
#!/usr/bin/env bash
AGENT_ID=$1
MESSAGE=$2
LEVEL=${3:-INFO}  # INFO, UPDATE, BLOCKED, COMPLETE

# Send structured message to PM
./send-claude-message.sh semantest:0 \
  "@PM [${LEVEL}] ${AGENT_ID}: ${MESSAGE}"
```

Agents would use:
```bash
./agent-log.sh alex "Starting WebSocket implementation" UPDATE
./agent-log.sh alex "BLOCKED: Need AWS credentials" BLOCKED
```

## Recommendation

Keep the explicit messaging approach because:

1. **Clarity**: Messages are intentional, not accidental
2. **Structure**: Can include metadata (urgency, type, etc.)
3. **Filtering**: PM only gets relevant updates
4. **Debugging**: Easy to trace communication flow
5. **Compatibility**: Works with Claude's interactive nature

## Hybrid Approach

If you want automatic capture, consider:

1. Keep explicit messaging for important updates
2. Add optional stdout monitoring for debugging
3. Use structured markers that agents can include:

```
[PM-STATUS] Starting implementation
[PM-BLOCKED] Need credentials
[PM-COMPLETE] Task finished
```

Then filter stdout for these markers only.