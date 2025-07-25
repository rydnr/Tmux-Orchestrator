# Agent Access Architecture - Solving the Directory Constraint

## The Core Problem

Claude agents have a fundamental security constraint: they can only access files in their launch directory and subdirectories. They CANNOT access parent directories or sibling directories.

### Current Problem Structure
```
/home/chous/work/
├── tmux-orchestrator/         # Orchestration scripts
│   ├── send-claude-message.sh
│   ├── message-agent.sh
│   └── spawn-*.sh
└── semantest/                 # Project directory
    └── [Agents launched here can't access ../tmux-orchestrator/]
```

## Why This Matters

1. **Script Access**: Agents can't use orchestration scripts
2. **Communication**: Agents can't message each other properly  
3. **Coordination**: Wake schedulers and other tools fail
4. **Scalability**: Problem gets worse with multiple projects

## Solution Patterns

### Pattern 1: Workspace Launch (Recommended)
Launch all agents from a parent directory that contains both orchestrator and projects.

```bash
cd /home/chous/work
./tmux-orchestrator/spawn-superclaude-agent.sh alice backend cautious semantest ./semantest
```

**Pros**: Simple, no copying, full access
**Cons**: Requires changing launch location

### Pattern 2: Workspace Directories
Create dedicated workspace directories with proper structure:

```
/home/chous/work/workspace-semantest/
├── .orchestrator -> ../tmux-orchestrator/  # Symlink
├── project -> ../semantest/                # Symlink
└── [launch agents here]
```

**Pros**: Clean separation, multiple projects
**Cons**: Extra directory layer

### Pattern 3: Script Distribution
Copy essential scripts to each project:

```bash
# In spawn scripts
cp $TMUX_ORCHESTRATOR_FOLDER/essential-scripts/* $PROJECT_DIR/.orchestrator/
```

**Pros**: Works with existing structure
**Cons**: Duplication, sync issues

### Pattern 4: Monorepo Structure
Restructure everything under one parent:

```
/home/chous/work/ai-development/
├── orchestrator/      # Shared tools
├── projects/
│   ├── semantest/
│   └── other-project/
└── workspaces/       # Agent launch points
```

**Pros**: Scalable, clean
**Cons**: Major restructuring

## Implementation Guide

### Quick Fix (Existing Projects)
```bash
# Run the fix script
./tmux-orchestrator/fix-agent-access.sh semantest

# This creates a workspace with proper access
# Then relaunch agents from the workspace
```

### New Project Setup
```bash
# 1. Create project
mkdir /home/chous/work/my-project

# 2. Create workspace
./tmux-orchestrator/fix-agent-access.sh my-project

# 3. Launch agents from workspace
cd /home/chous/work/workspace-my-project
./launch-agent.sh alice backend cautious my-project
```

### Best Practices

1. **Always Launch from Parent**: Launch agents from a directory that contains both orchestrator and project
2. **Use Workspaces**: Create dedicated workspace directories for complex projects
3. **Document Launch Location**: Clearly document where agents should be launched from
4. **Test Access**: Verify agents can access both orchestrator scripts and project files

## Migration Strategy

### For Existing Agents
1. Save current work (commits, state)
2. Create workspace directory
3. Terminate existing agents
4. Relaunch from workspace
5. Restore context with CLAUDE.md

### For New Projects
1. Start with workspace structure from day one
2. Use launch helpers
3. Document in project README

## Long-term Solution

Consider proposing to Anthropic:
- Allow agents to access a designated "tools" directory outside project
- Environment variable for trusted script locations
- Explicit permission system for parent directory access

## Verification Checklist

- [ ] Agents can access orchestrator scripts
- [ ] Message passing works between agents
- [ ] Wake schedulers can reach agents
- [ ] Agents can read/write project files
- [ ] No "file not found" errors for scripts

## Emergency Workarounds

If you can't restructure:
1. Copy essential scripts to project: `cp tmux-orchestrator/{message-agent,send-claude-message}.sh semantest/`
2. Use full paths in messages (won't work for agent execution)
3. Create proxy scripts that relay commands
4. Use git submodules to include orchestrator in project

## Conclusion

The directory access constraint is fundamental to Claude's security model. The best approach is to structure your directories with this constraint in mind from the start. For existing projects, use workspaces or script distribution to work around the limitation.