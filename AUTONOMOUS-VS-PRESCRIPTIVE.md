# Autonomous vs Prescriptive Agent Approaches

## Overview

The tmux-orchestrator now supports two different approaches for SuperClaude agents:

### 1. Prescriptive Approach (Original)
Agents are given specific commands and flags to use based on their role.

### 2. Autonomous Approach (New)
Agents decide their own tool usage based on task complexity and needs.

## Comparison

| Aspect | Prescriptive | Autonomous |
|--------|-------------|------------|
| **Tool Selection** | Pre-configured by role | Agent decides per task |
| **Thinking Modes** | Fixed (e.g., architect always uses --ultrathink) | Dynamic based on complexity |
| **MCP Servers** | Pre-assigned | Activated as needed |
| **Flexibility** | Limited | High |
| **Learning Curve** | Lower | Higher (agents need to understand options) |
| **Efficiency** | May overuse resources | Optimized per task |

## When to Use Each

### Use Prescriptive (`spawn-semantest-team.sh`) When:
- You want predictable behavior
- Agents are new to SuperClaude
- You have specific tool requirements
- Training new team members

### Use Autonomous (`spawn-autonomous-team.sh`) When:
- Agents understand SuperClaude capabilities
- Tasks vary in complexity
- You want optimal resource usage
- Encouraging agent independence

## Examples

### Prescriptive Backend Agent
```bash
# Always uses these tools:
/sc:implement feature --seq --c7
# Even for simple tasks that don't need them
```

### Autonomous Backend Agent
```bash
# Simple task:
/sc:implement simple-endpoint

# Complex task (agent decides):
/sc:implement complex-queue --think --seq

# Critical task (agent escalates):
/sc:implement payment-system --ultrathink --seq --c7
```

## How Autonomous Agents Decide

1. **Task Assessment**
   - Read requirements
   - Evaluate complexity
   - Consider dependencies

2. **Tool Selection**
   ```
   if task.complexity > 0.8:
       use "--ultrathink"
   elif task.complexity > 0.5:
       use "--think"
   
   if task.needs_patterns:
       use "--c7"
   
   if task.has_complex_logic:
       use "--seq"
   ```

3. **Execution**
   - Start with minimal tools
   - Add as needed
   - Learn from outcomes

## PM's Role in Each Approach

### Prescriptive PM
```
"Backend, implement the queue using /sc:implement --seq --c7"
"Frontend, build the UI with /sc:build --magic"
```

### Autonomous PM
```
"Backend, we need a download queue system"
"Frontend, users need a folder selection interface"
(Agents decide their own tools)
```

## Benefits of Autonomy

1. **Efficiency**: No wasted tokens on unnecessary flags
2. **Adaptability**: Agents adjust to task requirements
3. **Learning**: Agents improve tool selection over time
4. **Innovation**: Agents might find better tool combinations
5. **Ownership**: Agents take responsibility for their choices

## Migration Path

1. Start with prescriptive for new teams
2. Educate agents about SuperClaude options
3. Gradually allow tool choice freedom
4. Move to full autonomy when ready

## Quick Start

### Prescriptive Team
```bash
cd /home/chous/work
./tmux-orchestrator/spawn-semantest-team.sh
```

### Autonomous Team
```bash
cd /home/chous/work
./tmux-orchestrator/spawn-autonomous-team.sh semantest
```

Both include all wake schedulers and full SuperClaude support!