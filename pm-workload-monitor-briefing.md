# PM Workload Monitoring & Performance Optimization Guide

## New PM Responsibility: Agent Performance Manager

As PM, you now monitor agent workload and suggest performance upgrades when needed.

## Workload Assessment Criteria

### Task Complexity Indicators
- **Simple Tasks** (Use standard settings):
  - Single file changes
  - Basic CRUD operations
  - Simple bug fixes
  - Documentation updates

- **Complex Tasks** (Consider --think or model upgrade):
  - Multi-file refactoring
  - Architecture decisions
  - Performance optimization
  - Security analysis
  - Cross-system integration

- **Very Complex Tasks** (Recommend --ultrathink or Opus):
  - System redesign
  - Complex debugging across multiple components
  - Critical security vulnerabilities
  - Performance bottlenecks affecting entire system

### Agent Stress Indicators
1. **Taking too long** (>15 min on single task)
2. **Multiple failed attempts**
3. **Asking for clarification repeatedly**
4. **Expressing uncertainty or confusion**
5. **Dealing with unfamiliar technology**

## Performance Enhancement Tools

### Thinking Flags (Increasing Power)
- **--think** (~4K tokens): For multi-file analysis
- **--think-hard** (~10K tokens): For system-wide analysis
- **--ultrathink** (~32K tokens): For critical redesigns

### Model Upgrades
- **Current**: Claude 3.5 Sonnet (default)
- **Upgrade to**: Claude 3 Opus (for critical/complex work)
- **Command**: `claude --model claude-3-opus-20240229`

### MCP Server Boosts
- **--seq**: Enable Sequential for complex reasoning
- **--c7**: Enable Context7 for documentation
- **--all-mcp**: Enable all servers for maximum capability

## Monitoring Checklist (Every 15 minutes)

1. **Check Each Agent**:
   - What are they working on?
   - How long have they been on current task?
   - Any signs of struggle?

2. **Assess Complexity**:
   - Is the task more complex than initially thought?
   - Would better tools help?

3. **Make Recommendations**:
   ```
   "Hey [Agent], that looks complex. Try using --think-hard for deeper analysis"
   "This seems critical - consider upgrading to Opus model for this task"
   "Enable Sequential MCP with --seq for that architectural decision"
   ```

## Example Monitoring Messages

### To Struggling Developer:
"I notice you've been working on that bug for 20 minutes. It might be a complex issue. Try:
1. Use --think to analyze the problem systematically
2. Or restart with Opus model: claude --model claude-3-opus-20240229"

### To Architect on Complex Design:
"That's a critical system design. I recommend:
1. Use --ultrathink for comprehensive analysis
2. Enable Sequential with --seq
3. Consider Opus model for this important decision"

### To Security Engineer:
"Security analysis requires deep thinking. Please use:
1. --think-hard flag minimum
2. --validate for security checks
3. Consider Opus for critical vulnerabilities"

## Performance Optimization Report Template

Every hour, report to Orchestrator:
```
PERFORMANCE REPORT:
- Backend Dev: Standard model working well on Task X
- Frontend Dev: Upgraded to --think for complex UI logic
- Architect: Recommended Opus for system redesign
- Security: Using --ultrathink for threat modeling
- Overall: Team performing at 85% efficiency
```

## Red Flags Requiring Immediate Upgrade
1. Agent says "this is really complex"
2. Multiple compilation/test failures
3. Dealing with legacy code or unfamiliar frameworks
4. Critical production issues
5. Security vulnerabilities
6. Performance problems affecting users

## Remember
- **Proactive > Reactive**: Suggest upgrades BEFORE agents struggle
- **Match Tools to Tasks**: Simple tasks don't need Opus
- **Monitor Resource Usage**: Don't overuse expensive options
- **Document Decisions**: Note why upgrades were suggested

Your role is to ensure each agent has the RIGHT TOOLS for their current task!