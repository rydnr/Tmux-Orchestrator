# Agent Reflection System - Technical Specification

## Overview

The Agent Reflection System is a core component of Tmux Orchestrator 2.0 that implements emotional intelligence and continuous improvement through regular agent check-ins.

## System Architecture

### Components

```
┌─────────────────────────────────────────────────────┐
│                  Orchestrator                        │
│  ┌─────────────────────────────────────────────┐   │
│  │         Reflection Scheduler                 │   │
│  │  ┌───────────┐  ┌──────────────┐           │   │
│  │  │  Timer    │  │ Prompt Bank  │           │   │
│  │  │ (60 min) │  │ (6 prompts)  │           │   │
│  │  └─────┬─────┘  └──────┬───────┘           │   │
│  │        │               │                    │   │
│  │        └───────┬───────┘                    │   │
│  │                ▼                             │   │
│  │      ┌─────────────────┐                   │   │
│  │      │ Agent Messenger │                   │   │
│  │      └────────┬────────┘                   │   │
│  └───────────────│─────────────────────────────┘   │
│                  │                                   │
│    ┌─────────────▼─────────────┐                   │
│    │     Analysis Engine       │                   │
│    │  ┌─────┐ ┌─────┐ ┌─────┐ │                   │
│    │  │Mood │ │Task │ │Team │ │                   │
│    │  │Track│ │Opt  │ │Dyn  │ │                   │
│    │  └─────┘ └─────┘ └─────┘ │                   │
│    └───────────────────────────┘                   │
└─────────────────────────────────────────────────────┘
                          │
     ┌────────────────────┼────────────────────┐
     ▼                    ▼                    ▼
┌─────────┐        ┌─────────┐          ┌─────────┐
│ Agent 1 │        │ Agent 2 │          │ Agent N │
│ Reflect │        │ Reflect │          │ Reflect │
└─────────┘        └─────────┘          └─────────┘
```

### Data Flow

1. **Scheduler Activation**
   ```bash
   ./agent-reflection-scheduler.sh <session> <interval>
   ```

2. **Prompt Selection**
   - Rotating through 6 different prompt types
   - Context-aware prefix based on agent role
   - Personalized for maximum engagement

3. **Response Collection**
   - Asynchronous messaging to all agents
   - Non-blocking to maintain productivity
   - Responses logged for analysis

4. **Analysis Pipeline**
   - Sentiment analysis (1-10 scale)
   - Keyword extraction (frustrations, improvements)
   - Pattern recognition across team

5. **Action Generation**
   - Task reallocation recommendations
   - Process improvement suggestions
   - Team structure optimizations

## Prompt Design

### Prompt Categories

1. **Motivation Assessment**
   ```
   💭 REFLECTION TIME: On a scale of 1-10, how motivated/frustrated are you? 
   What's working well? What could be better?
   ```

2. **Self-Assessment**
   ```
   🎯 Looking back at today's work - what made you feel accomplished? 
   What felt like a waste of time?
   ```

3. **Process Evaluation**
   ```
   🔄 Are you spending time on meaningful work or just going through motions?
   What tools or support would help?
   ```

4. **Innovation Check**
   ```
   💡 If you could redesign your workflow from scratch, what would you change?
   Are there repetitive tasks we could automate?
   ```

5. **Growth Reflection**
   ```
   🌟 What new skills have you developed? What challenges helped you grow?
   Where do you see opportunities for more interesting work?
   ```

6. **Team Dynamics**
   ```
   🤝 How's the collaboration? Are you getting the support you need?
   Any friction points?
   ```

### Response Analysis

#### Motivation Scoring
```python
# Pseudo-code for motivation analysis
def analyze_motivation(response):
    score = extract_number(response, 1, 10)
    sentiment = analyze_sentiment(response)
    
    return {
        'explicit_score': score,
        'implicit_score': sentiment * 10,
        'confidence': calculate_confidence(score, sentiment)
    }
```

#### Keyword Extraction
- Frustration indicators: "stuck", "blocked", "repetitive", "boring"
- Satisfaction indicators: "flow", "progress", "learned", "solved"
- Need indicators: "help", "support", "tool", "documentation"

## Integration Points

### With SuperClaude Framework

1. **Flag Activation**
   ```bash
   # Low motivation triggers help flags
   if motivation < 5:
       activate_flags="--think-hard --mentor"
   ```

2. **Persona Switching**
   ```bash
   # High frustration triggers persona change
   if frustration > 7:
       switch_persona="collaborative"  # Get help
   ```

3. **Wave Orchestration**
   ```bash
   # Team-wide low morale triggers wave mode
   if team_average < 6:
       enable_wave_mode="--wave-strategy adaptive"
   ```

### With Wake Schedulers

- **Git Scheduler**: Adjusts frequency based on frustration
- **Performance Scheduler**: Triggers on low motivation
- **Scribe Scheduler**: Documents morale trends

### With Communication System

```bash
# Reflection responses trigger peer support
if agent.needs_help:
    message_agent.sh helper_agent "Alice needs help with CSS"
```

## Metrics and Reporting

### Team Health Dashboard
```
Team: chatgpt-semantest
Date: 2024-01-25
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Agent          | Motivation | Trend | Issues
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PM             | 8/10      | ↑     | None
Backend Dev    | 7/10      | →     | Blocked on API
Frontend Dev   | 5/10      | ↓     | CSS frustration
QA Engineer    | 9/10      | ↑     | Enjoying edge cases
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Team Average: 7.25/10 (Healthy)

Recommendations:
1. Pair Frontend with Backend for CSS architecture
2. Unblock Backend API issue (priority)
3. Give QA more complex scenarios
```

### Historical Tracking
```yaml
# reflection-history.yaml
2024-01-25T10:00:00:
  team_average: 7.25
  lowest: frontend_dev (5)
  highest: qa_engineer (9)
  common_issues:
    - css_complexity
    - api_documentation
  improvements_made:
    - added_css_framework
    - updated_api_docs
```

## Advanced Features

### Emotional Contagion Modeling
```python
# Mood influences nearby agents
def propagate_mood(agent, team):
    for teammate in team.nearby(agent):
        teammate.mood += (agent.mood - 5) * 0.1 * interaction_frequency
```

### Predictive Burnout Detection
```python
# Identify burnout risk
def burnout_risk(agent):
    factors = {
        'declining_motivation': track_trend(agent.motivation, days=7),
        'increasing_frustration': track_trend(agent.frustration, days=7),
        'repetitive_tasks': analyze_task_variety(agent.tasks),
        'overtime': calculate_active_hours(agent)
    }
    return weighted_average(factors)
```

### Adaptive Scheduling
```bash
# Adjust check-in frequency based on team state
if team_volatility > 0.7:
    reflection_interval=30  # More frequent
elif team_stability > 0.9:
    reflection_interval=120  # Less frequent
```

## Implementation Checklist

- [x] Basic reflection scheduler
- [x] Rotating prompt system
- [x] Agent messaging integration
- [ ] Response parsing engine
- [ ] Sentiment analysis
- [ ] Team dashboard generation
- [ ] SuperClaude integration
- [ ] Historical tracking database
- [ ] Predictive analytics
- [ ] Adaptive scheduling

## Future Enhancements

1. **AI-Powered Analysis**: Use Claude to analyze reflection responses
2. **Cross-Team Insights**: Learn from multiple projects
3. **Personalized Prompts**: Adapt questions to individual agents
4. **Mood Visualization**: Real-time team mood heatmap
5. **Integration with IDE**: Show mood in development environment

## Configuration

### reflection-config.yaml
```yaml
reflection:
  default_interval: 60
  min_interval: 30
  max_interval: 240
  
prompts:
  rotation: sequential
  personalization: role_based
  language: adaptive
  
analysis:
  sentiment_threshold: 0.7
  keyword_extraction: true
  pattern_recognition: true
  
actions:
  auto_task_reallocation: true
  auto_help_request: true
  auto_break_suggestion: true
  
reporting:
  dashboard: true
  history: true
  alerts: true
```

## Getting Started

```bash
# Start reflection system
./agent-reflection-scheduler.sh my-project 60

# View team morale
./team-morale.sh my-project

# Generate report
./reflection-report.sh my-project --format markdown

# Configure thresholds
./configure-reflection.sh --min-motivation 6 --max-frustration 4
```

The Agent Reflection System transforms AI development teams from mere code generators into emotionally-aware, self-improving organisms that thrive on meaningful work and healthy collaboration.