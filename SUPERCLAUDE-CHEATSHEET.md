# SuperClaude Commands Cheatsheet for Agents

## Core Commands by Role

### 🏗️ Architect
- `/sc:analyze <target> --ultrathink --focus architecture` - Deep architectural analysis
- `/sc:design <system> --wave-mode` - System design with wave orchestration
- `/sc:improve <target> --arch` - Architectural improvements
- `/sc:estimate <feature> --complexity` - Architecture complexity estimation
- Create requirements in `requirements/REQ-XXX/` folders

### 💻 Backend Developer
- `/sc:implement <feature> --seq --c7` - Implement with Sequential thinking + Context7 patterns
- `/sc:analyze <api> --focus performance` - API performance analysis
- `/sc:improve <code> --perf` - Performance optimization
- `/sc:troubleshoot <issue> --think-hard` - Debug complex issues
- `/sc:build --api` - Build API endpoints

### 🎨 Frontend Developer
- `/sc:build <component> --magic` - Build UI components with Magic
- `/sc:implement <ui-feature> --magic --c7` - Implement with UI generation
- `/sc:improve <ui> --accessibility` - Improve accessibility
- `/sc:design <interface> --magic` - Design user interfaces
- `/sc:test <component> --playwright` - Test UI components

### 🧩 Extension Developer
- `/sc:implement <feature>` - Implement extension features
- `/sc:analyze <manifest>` - Analyze extension structure
- `/sc:build <popup>` - Build extension UI
- `/sc:test browser-extension --playwright` - Test extension
- `/sc:troubleshoot <browser-issue>` - Debug browser-specific issues

### 🧪 QA Engineer
- `/sc:test <feature> --playwright` - Comprehensive testing with Playwright
- `/sc:test e2e --comprehensive` - End-to-end testing
- `/sc:analyze --focus quality` - Quality assessment
- `/sc:improve --quality` - Quality improvements
- `/sc:document test-cases` - Document test scenarios

### 📝 Scribe
- `/sc:document <target>` - Create/update documentation
- `/sc:document journal.org --append` - Update journal
- `/sc:explain <concept> --detailed` - Create explanations
- `/sc:analyze --focus documentation` - Documentation coverage
- `/sc:git log --pretty` - Document git history

### 🚀 DevOps
- `/sc:git <operation>` - Git operations with best practices
- `/sc:analyze --focus infrastructure` - Infrastructure analysis
- `/sc:implement ci-cd` - Set up CI/CD pipelines
- `/sc:improve --security` - Security hardening
- `/sc:troubleshoot deployment` - Debug deployment issues

## Common Flags

### Thinking Modes
- `--think` - 4K token analysis for complex problems
- `--think-hard` - 10K token deep analysis
- `--ultrathink` - 32K token critical analysis

### MCP Servers
- `--c7` / `--context7` - Library documentation and patterns
- `--seq` / `--sequential` - Complex multi-step analysis
- `--magic` - UI component generation
- `--play` / `--playwright` - Browser automation and testing
- `--all-mcp` - Enable all MCP servers
- `--no-mcp` - Disable MCP servers

### Focus Areas
- `--focus performance` - Performance optimization
- `--focus security` - Security analysis
- `--focus quality` - Code quality
- `--focus architecture` - System design
- `--focus accessibility` - UI accessibility

### Efficiency
- `--uc` / `--ultracompressed` - Compressed output (30-50% tokens)
- `--verbose` - Detailed explanations
- `--validate` - Pre-execution validation
- `--safe-mode` - Conservative execution

### Special Modes
- `--loop` - Iterative improvement mode
- `--wave-mode` - Multi-stage wave orchestration
- `--delegate` - Spawn sub-agents for parallel work
- `--introspect` - Self-analysis mode

## Command Examples

### For Current Semantest Tasks

#### Backend: Implement Download Queue
```bash
/sc:implement imageDownloadRequested handler --seq --c7
# Then for the queue system:
/sc:implement download-queue --think --seq
```

#### Extension: Add Folder Selection
```bash
/sc:implement folder-selection-ui --magic
/sc:build download-button --folder-input
```

#### QA: Test Complete Flow
```bash
/sc:test image-generation-download --playwright --comprehensive
/sc:test e2e --from "click button" --to "file saved"
```

#### Architect: Review Download Architecture
```bash
/sc:analyze download-flow --ultrathink --focus architecture
# If improvements needed:
/sc:design improved-download-system --wave-mode
```

## Tips

1. **Start with `/sc:load`** to understand the project context
2. **Use role-specific commands** for better auto-persona activation
3. **Add thinking flags** for complex problems
4. **Enable MCP servers** based on task needs
5. **Use `/sc:improve --loop`** for iterative refinement
6. **Document decisions** with the scribe

## Quick Reference

| Command | Purpose | Best For |
|---------|---------|----------|
| `/sc:analyze` | Deep analysis | Architects, QA |
| `/sc:implement` | Feature implementation | Developers |
| `/sc:build` | Create new components | Frontend, Backend |
| `/sc:test` | Testing & validation | QA |
| `/sc:improve` | Enhance existing code | All roles |
| `/sc:document` | Documentation | Scribe |
| `/sc:git` | Version control | DevOps, All |
| `/sc:troubleshoot` | Debug issues | All roles |

Remember: SuperClaude commands automatically activate appropriate personas and MCP servers based on context!