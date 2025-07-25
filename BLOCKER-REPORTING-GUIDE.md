# Blocker Reporting Guide for Agents

## When You're Blocked

If you encounter something that prevents you from making progress AND requires action from rydnr, follow this protocol:

## 1. Identify if it's a True Blocker

**True Blockers** (report to PM immediately):
- ❌ Need extension signed for testing
- ❌ Missing GPG key for commits
- ❌ Need access to external service/API
- ❌ Require specific browser configuration
- ❌ Need clarification on requirements
- ❌ Missing credentials or permissions

**NOT Blockers** (solve with team):
- ✅ Technical implementation questions → Ask other agents
- ✅ Code debugging issues → Use SuperClaude tools
- ✅ Design decisions → Discuss with architect/PM
- ✅ Test failures → Work with QA

## 2. Report to PM

Send a clear message to PM:

```
@PM: I'm blocked on [specific task].

Issue: [Clear description]
What I need from rydnr: [Specific action]
Impact: [What can't proceed without this]

Example:
@PM: I'm blocked on testing the extension.

Issue: Chrome won't load unsigned extensions in normal mode
What I need from rydnr: Either sign the extension or provide developer mode instructions
Impact: Can't test the folder picker UI integration
```

## 3. PM Creates GitHub Issue

The PM will create a GitHub issue with `[BLOCKER]` prefix:

```bash
gh issue create --repo semantest/semantest \
  --title "[BLOCKER] Eva - Extension signing needed for testing" \
  --body "rydnr needs to:
  - Sign the extension for Chrome Web Store
  - Or provide developer testing credentials
  - Blocking: Extension testing and UI development
  
  Agent: Eva (Extension Developer)
  Window: semantest:2"
```

## 4. Wait for Resolution

While blocked:
- Work on non-blocked tasks if available
- Help other agents if possible
- Document the blocker in your code comments
- Be ready to resume when unblocked

## 5. PM Monitors GitHub

The PM checks GitHub every 15 minutes and will notify you when:
- rydnr responds with a solution
- The blocker is resolved
- There's a workaround available

## Common Blocker Examples

### Extension Developer
```
Blocker: Can't test extension installation
Need: Signed extension or test mode instructions
```

### Backend Developer
```
Blocker: Can't commit - GPG signing fails
Need: GPG key configuration help
```

### QA Engineer
```
Blocker: Can't access ChatGPT test account
Need: Test credentials from rydnr
```

### DevOps
```
Blocker: Can't push to GitHub
Need: Repository permissions
```

## Remember

- **Only PM creates GitHub issues** (to avoid duplicates)
- **Include `[BLOCKER]` in title** (rydnr monitors this)
- **Be specific** about what you need
- **Continue other work** while waiting
- **Check with PM** for updates

## Quick Template

```
@PM: BLOCKED

Task: [What you're trying to do]
Blocker: [What's preventing progress]
Need from rydnr: [Specific action required]
Can't continue: [What work is blocked]
```

This ensures rydnr is quickly aware of blockers and can unblock the team efficiently!