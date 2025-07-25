# GitHub Requirements Integration Guide

This system enables requirement management through GitHub issues, allowing remote collaboration when the orchestrator is away.

## Overview

Each requirement becomes a GitHub issue containing all three documents:
- **requirement.md** - What to build (PM owns)
- **design.md** - How to build (Architect owns)  
- **task.md** - Implementation breakdown (Developers own)

## Quick Start

### 1. Check if Project Uses GitHub
```bash
./github-requirement-manager.sh detect /path/to/project
```

### 2. Create Requirement with GitHub Issue
```bash
# Creates local files AND GitHub issue
./github-requirement-manager.sh create /path/to/project REQ-002 "Add user authentication"
```

### 3. Start Enhanced Wake Scheduler
```bash
# Monitors both local workflow AND GitHub issues
./github-wake-scheduler.sh chatgpt-semantest /home/chous/work/semantest 10
```

## How It Works

### For Local Team
1. Team works normally with local requirement files
2. Wake scheduler syncs changes to GitHub automatically
3. GitHub issues provide visibility and audit trail

### For Remote Orchestrator (You)
1. View requirements at: `https://github.com/[owner]/[repo]/issues`
2. Add comments for approval: "LGTM", "Approved", "Ship it"
3. Ask questions or provide feedback in comments
4. Wake scheduler detects your comments and notifies team

### Automatic Sync
- Local changes → GitHub issue updates
- GitHub comments → Team notifications
- Approval keywords trigger workflow progression

## GitHub Issue Format

Each issue contains:
```markdown
# REQ-XXX: Title

## 📋 Requirement Document
[Full requirement.md content]

## 🏗️ Design Document  
[Full design.md content]

## 📝 Task Breakdown
[Full task.md content]

## 🔄 Workflow Status
- [ ] Requirement approved
- [ ] Design approved
- [ ] Implementation started
```

## Remote Approval Flow

When you're away from the terminal:

1. **Review on Phone/Tablet**: Open GitHub issue
2. **Add Comment**: 
   - "Requirement approved - proceed with design"
   - "Design looks good - approved for development"
   - "Question: What about error handling?"
3. **Wake Scheduler Detects**: Notifies PM within 10 minutes
4. **Team Responds**: Updates issue with answers

## Benefits

- **Mobile Friendly**: Review and approve from anywhere
- **Audit Trail**: All decisions tracked in GitHub
- **Async Collaboration**: No need for real-time presence
- **Notifications**: GitHub can email/push notify you
- **Integration**: Works with existing GitHub workflows

## Commands Reference

### Create Issue Template
```bash
./github-requirement-manager.sh template /path/to/project
```

### Sync Existing Requirement
```bash
./github-requirement-manager.sh sync /path/to/project REQ-001 123
```

### Check for Updates
```bash
./github-requirement-manager.sh check /path/to/project REQ-001 123
```

## Setup Requirements

1. **GitHub CLI**: Install `gh` command
2. **Authentication**: Run `gh auth login`
3. **Repository**: Project must be a GitHub repository
4. **Permissions**: Need issue create/edit permissions

## Team Instructions

When using GitHub requirements:

1. **PM**: Monitor GitHub issues for orchestrator feedback
2. **Architect**: Update design in issue after requirement approval
3. **Developers**: Check issue comments for clarifications
4. **All**: Keep local files as source of truth, GitHub for collaboration

The wake scheduler handles all synchronization automatically!