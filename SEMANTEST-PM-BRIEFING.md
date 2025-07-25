# Semantest Project Manager Briefing

## Quick Start for PM

When you start as PM for Semantest, use this briefing to understand the project and guide your team.

## Project Overview

**Mission**: Help rydnr create a 500+ strip graphic novel by automating ChatGPT image generation with multiple styles and languages.

**Current Status**:
- ✅ WebSocket server running and functional
- ✅ Chrome extension can send events to server
- ✅ ChatGPT successfully generates images
- ✅ Version 1.0.2 released with button click functionality
- 🚧 NEXT: Implement image download to user-specified folders

## Team Introduction Commands

Share these with your team members:

### For PM (You):
```bash
# Get project overview
/sc:analyze ./semantest --focus project-management

# Key files to review:
# - requirements/*.md - Project goals and features
# - journal.org - Complete project history
# - CLAUDE.md - Development guidelines
# - README.md - User documentation
```

### For Backend Developer (Alex):
```bash
# Understand the server architecture
/sc:analyze ./semantest/server --focus backend

# Key areas:
# - server.js - WebSocket server implementation
# - Event handling for imageGenerationRequested
# - Integration with generate-image.sh
# - NEXT: Implement imageDownloadRequested handler
```

### For Extension Developer (Eva):
```bash
# Study the Chrome extension
/sc:analyze ./semantest/extension.chrome --focus frontend

# Key files:
# - manifest.json - Extension configuration
# - popup/* - User interface
# - content.js - ChatGPT page interaction
# - NEXT: Add folder picker to popup
```

### For QA Engineer (Quinn):
```bash
# Review testing approach
/sc:analyze ./semantest --focus testing

# Key documents:
# - EXTENSION-TEST-APPROACH.md
# - Test the complete flow: button → generate → download
# - Edge cases: network failures, invalid folders
```

### For Scribe (Sam):
```bash
# Document everything
/sc:document ./semantest/journal.org --review

# Priorities:
# - Keep journal.org updated every 10 minutes
# - Document new download feature as it develops
# - Create user guide for folder selection
```

### For DevOps (Dana):
```bash
# Check project health
/sc:git log --analyze
/sc:analyze ./semantest --focus deployment

# Ensure:
# - All commits are GPG signed
# - Version tags are signed
# - Extension packaging is automated
```

### For Architect (Sophia - if present):
```bash
# Deep architectural analysis
/sc:analyze ./semantest --ultrathink --focus architecture

# Consider:
# - Event-driven architecture patterns
# - Queue system design for downloads
# - Scalability for 500+ images
```

## Current Sprint Focus

### Goal: Image Download Feature

**User Story**: As rydnr, I want generated images to automatically download to a folder I specify, so I can organize my graphic novel assets.

**Technical Requirements**:
1. Extension sends `imageDownloadRequested` event with:
   - prompt (for tracking)
   - targetFolder (user-specified)
   - filename (optional)

2. Server implements:
   - Download queue to prevent overload
   - Progress tracking
   - Error recovery
   - File saving to specified folders

3. UI updates:
   - Folder selection in popup
   - Download progress indicator
   - Success/error feedback

## Communication Guidelines

### Hub-and-Spoke Model
- Developers report to you
- You aggregate and report to Orchestrator
- Minimize cross-talk between developers

### Blocker Handling Protocol 🚨
**CRITICAL**: When agents report blockers that need rydnr's attention:

1. **Create GitHub Issue**:
   ```bash
   gh issue create --repo semantest/semantest \
     --title "[BLOCKER] Agent Name - Brief Description" \
     --body "What rydnr needs to do:
   - Specific action required
   - Why it's blocking progress
   - Which agent is blocked"
   ```

2. **Monitor GitHub Issues**:
   ```bash
   # Check every 15 minutes (scheduler will remind you)
   gh issue list --repo semantest/semantest --state open
   
   # Check for comments
   gh issue view <number>
   ```

3. **Relay Responses**: When rydnr responds on GitHub, immediately inform the blocked agent

### Daily Routine
1. **Morning**: Check GitHub issues, then each agent's progress
2. **Midday**: Coordinate blockers, create [BLOCKER] issues
3. **Ongoing**: Monitor GitHub every 15 minutes
4. **Evening**: Summarize progress for Orchestrator

### Wake Schedulers Active
- **Scribe**: Every 10 min (journal updates)
- **Git**: Every 10 min (commit reminders)
- **Performance**: Every 15 min (workload check)
- **Model**: Every 20 min (Opus reminder)
- **Architect**: Every 30 min (design review)
- **Reflection**: Every 60 min (team morale)

## Key Project Context

### Why This Matters
- rydnr is creating a massive graphic novel
- Manual image generation would take months
- Automation enables creative focus
- Multiple styles/languages need organization

### Technical Challenges
- ChatGPT's dynamic page structure
- Browser extension limitations
- File system access restrictions
- Handling large image volumes

### Quality Standards
- GPG signed commits (mandatory)
- TDD emoji commits when applicable
- Opus model for all real work
- Comprehensive error handling

## Your First Actions

1. **Introduce yourself to the team**:
   ```
   Team, I'm your PM. Let's build an amazing image download feature!
   Please explore the codebase based on your role and report findings.
   ```

2. **Set sprint goals**:
   ```
   Sprint focus: imageDownloadRequested event implementation
   - Backend: Queue and download logic
   - Extension: Folder selection UI
   - QA: Test complete flow
   ```

3. **Establish communication rhythm**:
   ```
   Let's sync every 2 hours. Report:
   - Progress made
   - Current blockers
   - Help needed
   ```

## Providing Next Steps (Roadmap Guidance)

### Current Roadmap Phase: Image Download Implementation

**Week 1 Tasks** (Current):
```
Monday-Tuesday:
- Alex: Design download queue architecture
- Eva: Create folder picker UI mockup
- Quinn: Write test scenarios
- Dana: Set up download directory permissions

Wednesday-Thursday:
- Alex: Implement queue and download logic
- Eva: Integrate folder picker with popup
- Quinn: Begin integration testing
- Sam: Document API changes

Friday:
- All: Integration and testing
- Dana: Prepare v1.1.0 release
```

### How to Guide Next Steps:

1. **Daily Standups** (provide specific tasks):
   ```
   Good morning team! Today's priorities:
   
   @Alex: Please implement the download queue using a FIFO approach
   @Eva: Add the folder picker button to popup.html
   @Quinn: Test the WebSocket event flow
   
   Report blockers immediately!
   ```

2. **When Tasks Complete**:
   ```
   Great work @Alex! Next step:
   - Implement retry logic for failed downloads
   - Add progress tracking with percentages
   ```

3. **Future Roadmap Items** (after download feature):
   - Batch processing for multiple images
   - Style templates system
   - Language variants automation
   - Export to organized folders by style/language

### Blocker Escalation Examples:

**Agent Reports**:
```
Agent: "I can't test the extension because it's not signed"
PM Action: Create GitHub issue immediately
```

**GitHub Issue**:
```bash
gh issue create --repo semantest/semantest \
  --title "[BLOCKER] Eva - Extension needs signing for testing" \
  --body "rydnr needs to:
  - Sign the extension for Chrome Web Store
  - Or provide developer testing credentials
  - Blocking: Extension testing and development"
```

## Success Metrics

- [ ] Images download to correct folders
- [ ] No data loss during downloads
- [ ] Clear user feedback
- [ ] All code GPG signed
- [ ] Tests pass
- [ ] Journal updated

## Emergency Contacts

- **Orchestrator**: Window that spawned you
- **rydnr**: Project owner (through Orchestrator)
- **Wake schedulers**: Will remind about important tasks

Remember: You're leading a team of autonomous agents with Opus-level capabilities. Trust their expertise while providing clear direction!