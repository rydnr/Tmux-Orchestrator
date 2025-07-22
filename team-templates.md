# SuperClaude Team Templates v2.0

## Quick Start

```bash
# Spawn a distributed systems team
./superclaude-framework-v2.sh spawn "Semantest CLI Framework" distributed_systems /home/chous/work/semantest

# List all available profiles  
./superclaude-framework-v2.sh list

# Connect to spawned team
tmux attach-session -t semantest-cli-framework
```

## Team Profiles

### 🏗️ distributed_systems
**Best for**: Complex backend systems, distributed architectures, event-driven systems  
**Size**: 9 agents  
**Personas**: architect, engineer, devops, qa, security, scribe  
**MCP Servers**: sequential, context7, playwright  
**Auto-Flags**: --think-hard --delegate --wave-mode  
**Wake Schedule**: Every 10 minutes  

**Use Cases**:
- Microservices architecture
- Event-driven systems  
- CLI/SDK development
- Complex backend APIs

### 🎨 frontend_focused
**Best for**: UI/UX heavy projects, design systems, user-facing applications  
**Size**: 6 agents  
**Personas**: architect, frontend, ux, qa, scribe  
**MCP Servers**: magic, shadcn-ui, playwright, context7  
**Auto-Flags**: --magic --uc --persona-frontend  
**Wake Schedule**: Every 15 minutes  

**Use Cases**:
- React/Vue applications
- Design system development
- Browser extensions (UI layer)
- Dashboard/admin panels

### ⚙️ backend_focused  
**Best for**: Server-side development, APIs, data processing  
**Size**: 7 agents  
**Personas**: architect, backend, engineer, devops, qa, security, scribe  
**MCP Servers**: sequential, context7  
**Auto-Flags**: --seq --c7 --persona-backend  
**Wake Schedule**: Every 12 minutes  

**Use Cases**:
- REST/GraphQL APIs
- Database design  
- Server infrastructure
- Data processing pipelines

### 🔬 research_heavy
**Best for**: Research, analysis, documentation, proof of concepts  
**Size**: 4 agents  
**Personas**: analyzer, architect, scribe  
**MCP Servers**: sequential, context7  
**Auto-Flags**: --ultrathink --seq --c7  
**Wake Schedule**: Every 30 minutes  

**Use Cases**:
- Technology research
- Architecture analysis
- Documentation projects
- Feasibility studies

### 🌐 fullstack_webapp
**Best for**: Complete web applications, SaaS products  
**Size**: 8 agents  
**Personas**: architect, frontend, backend, ux, qa, devops, scribe  
**MCP Servers**: magic, sequential, context7, playwright  
**Auto-Flags**: --delegate --wave-mode  
**Wake Schedule**: Every 10 minutes  

**Use Cases**:
- Full web applications
- SaaS platforms
- E-commerce sites
- Progressive web apps

### 🔒 security_focused
**Best for**: Security audits, penetration testing, compliance  
**Size**: 5 agents  
**Personas**: architect, security, qa, backend, scribe  
**MCP Servers**: sequential, context7  
**Auto-Flags**: --think-hard --validate --persona-security  
**Wake Schedule**: Every 15 minutes  

**Use Cases**:
- Security audits
- Vulnerability assessments
- Compliance projects
- Security tool development

## MCP Server Assignments

| Persona | Auto-Assigned MCPs | Primary Use |
|---------|-------------------|-------------|
| architect | sequential, context7 | System design, architecture patterns |
| frontend | magic, shadcn-ui, context7 | UI components, design systems |
| backend | sequential, context7 | Complex logic, backend patterns |
| ux | magic, context7 | Design components, UX patterns |
| qa | playwright, sequential | E2E testing, systematic testing |
| security | sequential, context7 | Security analysis, threat modeling |
| devops | sequential, context7 | Infrastructure analysis, deployment |
| scribe | context7 | Documentation patterns, writing |
| engineer | sequential, context7 | Implementation, complex logic |
| analyzer | sequential, context7 | Root cause analysis, investigation |

## Communication Patterns

### Layer 1: Direct Agent Communication ✅
```bash
# Agent-to-agent communication
/home/chous/work/tmux-orchestrator/send-claude-message.sh session:window 'message'

# Example: QA asks Engineer about test coverage
/home/chous/work/tmux-orchestrator/send-claude-message.sh project:2 'What test coverage do we have for the auth module?'
```

### Layer 2: PM Coordination ✅
- Agents report completion/blockers to PM
- PM removes obstacles and coordinates resources
- PM ensures quality gates and commits

### Layer 3: Wake-up Accountability ✅  
- Automated reminders every 10-30 minutes
- MCP usage verification
- Collaboration monitoring

### Layer 4: Cross-Team Communication 🆕
```bash
# For multiple teams on same project
./superclaude-framework-v2.sh spawn "Frontend Team" frontend_focused
./superclaude-framework-v2.sh spawn "Backend Team" backend_focused

# Coordinator can message between teams
/home/chous/work/tmux-orchestrator/send-claude-message.sh frontend-team:0 'Backend team reports API ready for integration'
```

## Quality Gates

### Pre-Spawn Checklist
- [ ] Choose appropriate team profile for project type
- [ ] Verify project directory exists and is accessible
- [ ] Ensure tmux and claude CLI are available
- [ ] Test send-claude-message.sh script works

### Post-Spawn Verification
- [ ] PM bash tool working (auto-tested)
- [ ] All agents respond with "READY"
- [ ] MCP servers loaded for each agent
- [ ] Direct communication examples working
- [ ] Wake-up scheduler running
- [ ] Team summary file created

### Ongoing Quality Checks
- [ ] Regular commits being made
- [ ] Agents using appropriate MCP servers
- [ ] PM helping (not coding solo)
- [ ] Direct agent collaboration active
- [ ] Documentation being updated

## Advanced Usage

### Custom Team Spawning
```bash
# Add new profiles by editing superclaude-framework-v2.sh
# Add to TEAM_PROFILES associative array

TEAM_PROFILES[my_custom_profile]="size:5,personas:architect,engineer,qa,mcps:sequential,context7,flags:--delegate,wake:20"
```

### Multi-Project Coordination
```bash
# Spawn main orchestrator
tmux new-session -d -s orchestrator -c /home/chous/work

# Spawn specialist teams  
./superclaude-framework-v2.sh spawn "Project A - Backend" backend_focused /home/chous/work/project-a
./superclaude-framework-v2.sh spawn "Project A - Frontend" frontend_focused /home/chous/work/project-a  

# Coordinate between teams via orchestrator
```

### Team Lifecycle Management
```bash
# View active teams
tmux list-sessions | grep -E "(semantest|project)"

# Kill specific team
tmux kill-session -t team-name

# Stop wake-up scheduler
kill $(cat /tmp/team-name_scheduler.pid)

# Clean up files
rm /tmp/team-name_*
```

## Troubleshooting

### Common Issues

**PM not responding to commands**
- Check bash tool access: `echo 'test'` in PM window
- Verify window number: PM should be window 0
- Test send-claude-message.sh manually

**Agents not loading MCP servers**
- Check internet connection for MCP downloads
- Verify claude CLI has MCP support
- Check specific MCP server status

**Wake-up scheduler not working**  
- Check if scheduler PID file exists: `/tmp/session_scheduler.pid`
- Verify scheduler process: `ps aux | grep wake`
- Check logs: `/tmp/session_wake_log.log`

**Communication issues**
- Test send-claude-message.sh script directly
- Verify tmux session and window names
- Check window numbering (0=PM, 1+=agents)

### Best Practices

1. **Start Small**: Use research_heavy (4 agents) for new projects
2. **Scale Up**: Move to distributed_systems (9 agents) for complex work  
3. **Specialize**: Use focused profiles (frontend, backend, security) for specific phases
4. **Monitor**: Check wake-up logs and team summaries regularly
5. **Clean Up**: Kill old teams and schedulers when done

---

*SuperClaude Framework v2.0 - Enhanced Team Orchestration*