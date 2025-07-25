# Project Manager Guide for Autonomous Teams

## Leading Autonomous SuperClaude Agents

As a PM of autonomous agents, your role shifts from prescribing tools to providing context and goals.

## Key Principles

### 1. Focus on WHAT, not HOW
❌ **Don't say**: "Use /sc:implement with --seq --c7 for the queue"
✅ **Do say**: "We need a reliable queue system for image downloads"

### 2. Provide Context, Not Commands
❌ **Don't say**: "Run /sc:analyze with --ultrathink"
✅ **Do say**: "This is a critical system that handles payments, so thorough analysis is important"

### 3. Trust Agent Expertise
- Agents know their SuperClaude tools
- They can assess complexity
- They'll escalate when needed

## Communication Templates

### Initial Briefing
```
Team, here's our current status and priorities:

COMPLETED:
- WebSocket connection established ✓
- ChatGPT image generation working ✓
- Extension popup with button (v1.0.2) ✓

CURRENT PRIORITY: Image Download Feature
- Users need to download generated images
- Images should save to user-specified folders
- System should queue requests to prevent overload

CONSTRAINTS:
- Must maintain GPG signing on all commits
- Follow TDD emoji system when applicable
- Update journal regularly

Each of you has SuperClaude tools available. Assess task complexity and choose appropriate tools. If something seems particularly complex or risky, don't hesitate to use advanced analysis modes.
```

### Task Assignment
```
@Alex (Backend): Please implement the download queue system. Consider:
- Handling concurrent download requests
- Error recovery for failed downloads
- Progress tracking

@Eva (Extension): The popup needs folder selection. Think about:
- User-friendly folder picker
- Remembering user preferences
- Clear download status feedback

Choose whatever SuperClaude tools you need based on complexity.
```

### Encouraging Tool Usage
When you notice an agent might benefit from better tools:

```
@Quinn: That test scenario sounds complex with many edge cases. Have you considered whether advanced analysis might help identify all test paths?
```

NOT: "Use --ultrathink for that"

### Performance Monitoring
```
Team check-in: How's everyone doing with their current tasks?
- Any blockers?
- Any tasks more complex than initially thought?
- Anyone need to escalate their analysis tools?
```

## Red Flags to Watch For

1. **Agent Struggling**: Suggest they reassess complexity
2. **Repeated Failures**: Ask if different tools might help
3. **Time Pressure**: Remind them that --think modes exist
4. **Critical Tasks**: Emphasize importance, let them choose tools

## Sample PM Responses

### When Agent Asks About Tools
**Agent**: "Should I use --ultrathink for this?"
**PM**: "You're the expert on backend complexity. If you think it needs deep analysis, trust your judgment."

### When Agent Reports Issues
**Agent**: "The implementation is trickier than expected"
**PM**: "Thanks for the update. Do you have what you need to tackle the complexity, or would different analysis help?"

### When Coordinating Agents
**PM**: "Eva and Alex need to coordinate on the event structure. Please work together to define the interface. Use whatever collaboration tools help."

## Weekly Patterns

### Monday: Goal Setting
- Present week's objectives
- Let agents assess complexity
- Trust their tool estimates

### Wednesday: Mid-week Check
- Review progress
- Ask about tool effectiveness
- Adjust if needed

### Friday: Reflection
- What tools worked well?
- What would agents do differently?
- Learning for next week

## Emergency Situations

Even with autonomy, sometimes you need to intervene:

### Critical Bug
"Team, we have a critical production issue. This needs our most thorough analysis. I trust you to use appropriate tools for the severity."

### Deadline Pressure
"We have 2 hours to deliver. Please balance thoroughness with speed in your tool choices."

### New Technology
"This uses a framework none of us know well. Consider using documentation tools (--c7) liberally."

## Success Metrics

### Good Autonomous Team Signs
- Agents explain their tool choices
- Tools match task complexity
- Efficient token usage
- High-quality outputs
- Agents learn from experience

### Warning Signs
- Always using maximum tools
- Never using advanced tools
- Asking permission for every decision
- Tool choice doesn't match results

## Remember

Your autonomous agents are professionals who:
- Understand their tools
- Can assess complexity
- Want to do good work
- Will ask for help when needed

Trust them, guide them, but don't micromanage their tool choices!