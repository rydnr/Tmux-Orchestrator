# SuperClaude Framework v2.0 - Quick Start

## 🚀 **Immediate Usage**

### Spawn Your First Enhanced Team
```bash
# Navigate to orchestrator directory
cd /home/chous/work/tmux-orchestrator

# Make framework executable (if not already done)
chmod +x superclaude-framework-v2.sh

# Spawn a team for your project
./superclaude-framework-v2.sh spawn "My Project" distributed_systems /path/to/project

# Connect to the team
tmux attach-session -t my-project
```

### Available Team Profiles
```bash
# See all available profiles
./superclaude-framework-v2.sh list

# Quick reference:
# distributed_systems - 9 agents, complex backend systems
# frontend_focused    - 6 agents, UI/UX heavy projects  
# backend_focused     - 7 agents, server-side development
# research_heavy      - 4 agents, analysis and documentation
# fullstack_webapp    - 8 agents, complete web applications
# security_focused    - 5 agents, security audits and compliance
```

## ✅ **What You Get Automatically**

### Enhanced PM with Superpowers
- ✅ Bash tool validation on startup
- ✅ MCP servers: Sequential + Context7  
- ✅ Wake-up accountability every 10-30 minutes
- ✅ Direct team communication protocols
- ✅ Obstacle removal guidance

### Intelligent Agent Assignment
- ✅ MCP servers auto-assigned by role
- ✅ Role-specific briefings and focus areas
- ✅ Direct communication training
- ✅ Quality gate awareness

### Automated Management
- ✅ Wake-up scheduler with enhanced messages
- ✅ Team summary documentation
- ✅ Communication protocol training
- ✅ MCP utilization reminders

## 🎯 **Immediate Improvements Over v1.0**

| Feature | v1.0 | v2.0 |
|---------|------|------|
| Team Spawning | Manual | Automated templates |
| MCP Assignment | Manual | Auto-assigned by role |  
| Communication | Basic | Multi-layer with direct agent-to-agent |
| Wake-up Messages | Basic | MCP-aware + quality focused |
| PM Training | None | Comprehensive obstacle removal |
| Quality Gates | Manual | Integrated validation |

## 🔧 **Key Commands**

### Team Management
```bash
# Spawn team
./superclaude-framework-v2.sh spawn "Project Name" [profile] [directory]

# Connect to team
tmux attach-session -t project-name

# List active teams  
tmux list-sessions

# Kill team
tmux kill-session -t project-name
```

### Communication  
```bash
# Send message to agent
/home/chous/work/tmux-orchestrator/send-claude-message.sh session:window 'message'

# Example: PM talks to Engineer
/home/chous/work/tmux-orchestrator/send-claude-message.sh my-project:2 'What is the current status of the API implementation?'

# Example: QA talks to Engineer  
/home/chous/work/tmux-orchestrator/send-claude-message.sh my-project:2 'I need test data for the authentication module'
```

### Monitor Team
```bash
# Check wake-up scheduler
ps aux | grep wake

# View wake-up logs
tail -f /tmp/project-name_wake_log.log

# View team summary
cat /tmp/project-name_team_summary.md
```

## 🎪 **Example Team Spawn**

### For the Semantest CLI Project
```bash
# Spawn appropriate team for distributed CLI/SDK system
./superclaude-framework-v2.sh spawn "Semantest CLI Framework" distributed_systems /home/chous/work/semantest

# This creates:
# - 9 agents with specialized roles
# - Sequential MCP for complex analysis  
# - Context7 MCP for documentation
# - Wake-up every 10 minutes
# - Direct communication protocols
# - Quality gate integration
```

### Expected Team Windows
```
Window 0: PM (Project Manager)
Window 1: architect  
Window 2: engineer
Window 3: devops
Window 4: qa
Window 5: security  
Window 6: scribe
```

## ⚡ **Immediate Actions**

### For PM (Window 0)
1. Responds "READY" 
2. Establishes communication with all agents
3. Assesses project status
4. Identifies and removes blockers
5. Coordinates CLI development priorities

### For Architect (Window 1)  
1. Uses Sequential MCP for system design
2. Plans CLI → Server → Extension architecture
3. Coordinates with Engineer on implementation
4. Documents architectural decisions

### For Engineer (Window 2)
1. Uses Sequential MCP for complex logic
2. Implements CLI event wrapper
3. Coordinates with DevOps on deployment
4. Reports progress to PM

## 🛠 **Quality Assurance Built-In**

### Automatic Validations
- ✅ PM bash tool tested on spawn
- ✅ MCP servers loaded and verified
- ✅ Communication protocols established
- ✅ Wake-up accountability active

### Ongoing Quality Checks
- ✅ MCP utilization monitoring
- ✅ Direct communication encouragement  
- ✅ Quality gate enforcement
- ✅ Progress validation requirements

## 🎯 **Success Indicators**

Within 30 minutes of spawning, you should see:
- [ ] All agents respond "READY"
- [ ] PM actively helping (not coding)
- [ ] Direct agent-to-agent communication
- [ ] MCP servers being used (--seq, --c7, --magic)
- [ ] Regular commits being made
- [ ] Wake-up scheduler providing accountability

## 🚨 **Troubleshooting**

### PM Not Responding
```bash
# Check if bash tool works
tmux capture-pane -t session:0 -p | tail -10

# Test manual message
/home/chous/work/tmux-orchestrator/send-claude-message.sh session:0 'Test message'
```

### Agents Not Communicating  
```bash
# Verify window numbers
tmux list-windows -t session

# Test direct communication
/home/chous/work/tmux-orchestrator/send-claude-message.sh session:1 'Direct communication test'
```

### Wake-up Scheduler Issues
```bash
# Check if running
ps aux | grep session_wake

# Check logs  
tail /tmp/session_wake_log.log

# Restart if needed
kill $(cat /tmp/session_scheduler.pid)
# Re-spawn team to restart scheduler
```

---

**Ready to spawn your first SuperClaude v2.0 team!** 🚀