# Model Optimization Guide for Agents

## Understanding Claude Models

### Available Models (Quality First Approach)

| Model | Speed | Capability | When to Use | Our Standard |
|-------|-------|-----------|-------------|--------------|
| **Opus** | ⚡ | Advanced | DEFAULT for all real work | ✅ **STANDARD** |
| **Sonnet** | ⚡⚡ | Balanced | Only simple features | ⚠️ Downgrade |
| **Haiku** | ⚡⚡⚡ | Basic | Only trivial tasks | ⚠️ Downgrade |

## When to Use Each Model

### Opus (DEFAULT - Quality Standard)
Use for:
- ✅ ALL feature implementation
- ✅ ALL debugging
- ✅ ALL code reviews
- ✅ ALL test writing
- ✅ ALL refactoring
- ✅ ALL architecture work
- ✅ ALL production code
- ✅ Basically EVERYTHING that matters

```bash
# Standard Opus work (99% of tasks)
/sc:implement any-feature
/sc:analyze any-code
/sc:build any-component
/sc:test any-functionality
/sc:improve any-system
```

### Sonnet (Downgrade Only When...)
ONLY for:
- ⚠️ Very simple CRUD operations
- ⚠️ Basic formatting tasks
- ⚠️ Simple configuration changes
- ⚠️ Non-critical documentation

```bash
# Rare Sonnet tasks
/sc:implement simple-getter  # Even this deserves Opus!
/sc:format basic-file       # Maybe acceptable
```

### Haiku (Extreme Downgrade)
ONLY for:
- ⚠️ git status
- ⚠️ ls commands
- ⚠️ pwd
- ⚠️ Simple file existence checks
- ⚠️ Trivial one-liners

```bash
# The ONLY good Haiku tasks
/sc:git status
ls -la
pwd
```

## Model Switching Commands

### Check Current Model
```bash
/model
```

### Switch Models
```bash
/model haiku   # Switch to fast mode
/model sonnet  # Switch to balanced mode
/model opus    # Switch to maximum capability
```

## Quality-First Model Usage

### 1. Default to Excellence
```bash
# Start every session on Opus
/model opus  # If not already

# Only downgrade for truly trivial tasks
/model haiku
git status  # OK for this
/model opus  # Back to quality immediately
```

### 2. Typical Day (99% Opus)
```bash
# Morning - Opus all day
/model opus
/sc:git pull
/sc:analyze current-tasks
/sc:implement feature
/sc:test implementation
/sc:document changes
# Still on Opus - no switching needed!
```

### 3. Quality Standards
We prioritize:
- Code quality over speed
- Deep understanding over quick answers  
- Fewer bugs over more features
- Professional work over shortcuts

## Role-Specific Recommendations

### ALL ROLES
- **Default: OPUS** (Quality is non-negotiable)
- **Downgrade only for truly trivial tasks**

### Architects
- Stay on Opus 100% of the time
- Architecture work demands excellence

### Developers (Backend/Frontend/Extension)  
- Opus for ALL development
- Maybe Haiku for `git status` only

### QA Engineers
- Opus for ALL testing
- Quality assurance needs quality tools

### Scribes
- Opus for technical documentation
- Maybe Sonnet for meeting notes

### DevOps
- Opus for ALL infrastructure work
- Security and reliability demand the best

## Model + Flag Combinations

### Maximum Analysis Power
```bash
/model opus
/sc:analyze complex-system --ultrathink --seq --c7
```

### Efficient Implementation
```bash
/model sonnet
/sc:implement feature --think --c7
```

### Quick Checks
```bash
/model haiku
/sc:test smoke-tests
```

## Warning Signs You Need a Better Model

1. **Hitting token limits frequently**
   - Upgrade to model with higher limits

2. **Shallow analysis results**
   - Complex topics need Opus

3. **Repeated failed attempts**
   - Better model might understand nuance

4. **Taking too long on simple tasks**
   - Downgrade for efficiency

5. **Missing edge cases**
   - Opus catches more scenarios

## Model Scheduler Integration

The model wake scheduler (every 20 minutes) will:
- Remind you to check your model
- Suggest upgrades for complex work
- Encourage efficiency for simple tasks

Respond to prompts by:
1. Assessing current task complexity
2. Checking if model matches needs
3. Switching if beneficial

## Best Practices

1. **Don't Hoard Opus**: Use it when needed, but free it up for others
2. **Batch Complex Work**: Group Opus tasks together
3. **Document Model Needs**: Note when tasks require specific models
4. **Share Findings**: If you discover something with Opus, share with team
5. **Monitor Performance**: Track which model works best for which tasks

## Quick Decision Tree

```
What's your task?
├─ Any real work → Opus (DEFAULT)
├─ git status/ls/pwd → Haiku (OK to downgrade)
├─ Simple config edit → Maybe Sonnet
└─ Everything else → OPUS!

When in doubt: USE OPUS
```

Remember: Quality First! Opus is our standard because excellent work requires excellent tools!