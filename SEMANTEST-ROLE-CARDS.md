# Semantest Role-Specific Onboarding Cards

## 💻 Backend Developer Card (Alex)

### Your Mission
Implement robust server-side logic for downloading ChatGPT-generated images to user-specified folders.

### Quick Orientation
```bash
# Start here
/model opus  # Quality first!
/sc:analyze ./semantest/server --think

# Key files
server/server.js         # WebSocket server
server/handlers.js       # Event handlers  
generate-image.sh        # Current image generation
```

### Your Current Task
1. Implement `imageDownloadRequested` event handler
2. Create download queue system
3. Save images to specified folders
4. Handle errors gracefully

### Key Considerations
- Queue to prevent concurrent download overload
- Validate folder paths for security
- Track download progress
- Implement retry logic for failures

### Test Your Work
```bash
# Send test event
wscat -c ws://localhost:8080
> {"type":"imageDownloadRequested","prompt":"test","targetFolder":"/tmp/test"}
```

---

## 🧩 Extension Developer Card (Eva)

### Your Mission
Create intuitive UI for users to select download folders and track image generation/download progress.

### Quick Orientation
```bash
# Start here
/model opus
/sc:analyze ./semantest/extension.chrome --think

# Key files
extension.chrome/manifest.json    # Extension config
extension.chrome/popup/*          # UI components
extension.chrome/content.js       # Page interaction
```

### Your Current Task
1. Add folder selection to popup
2. Send `imageDownloadRequested` events
3. Show download progress
4. Handle success/error states

### Key Considerations
- Chrome's file system API limitations
- User-friendly folder picker
- Clear progress indicators
- Persist user's folder preference

### Test Your Setup
```bash
# Load extension in Chrome
1. chrome://extensions/
2. Developer mode ON
3. Load unpacked → select extension.chrome/
```

---

## 🧪 QA Engineer Card (Quinn)

### Your Mission
Ensure the image download feature works flawlessly across all scenarios and edge cases.

### Quick Orientation
```bash
# Start here
/model opus
/sc:analyze ./semantest --focus testing

# Key documents
EXTENSION-TEST-APPROACH.md
test-scenarios.md (create this!)
```

### Your Test Scenarios
1. Happy path: Generate → Download → Verify
2. Invalid folder paths
3. Network interruptions
4. Concurrent downloads
5. Large images (>10MB)
6. Special characters in filenames

### Key Test Points
- Extension → Server communication
- Download queue behavior
- Error recovery mechanisms
- File integrity after download

### Automation Approach
```bash
# Consider Playwright for E2E
/sc:test download-flow --playwright
```

---

## 📝 Documentation Scribe Card (Sam)

### Your Mission
Maintain comprehensive documentation of the project's evolution and create user guides.

### Quick Orientation
```bash
# Start here
/model opus
/sc:document ./semantest/journal.org --review

# Key files
journal.org              # Project history
README.md               # User documentation
requirements/*.md       # Feature specs
```

### Your Priorities
1. Update journal.org every 10 minutes
2. Document download feature progress
3. Create user guide for folder selection
4. Track technical decisions

### Documentation Templates
```org
* Download Feature Implementation [2024-XX-XX]
** Technical Approach
** Challenges Encountered  
** Solutions Implemented
** User Guide
```

---

## 🚀 DevOps Engineer Card (Dana)

### Your Mission
Ensure code quality, automate deployments, and maintain security standards.

### Quick Orientation
```bash
# Start here
/model opus
/sc:git log --analyze
/sc:analyze .github/workflows

# Check
- GPG signing status
- CI/CD pipelines
- Extension packaging
```

### Your Responsibilities
1. Enforce GPG signing on all commits
2. Automate extension building
3. Version management
4. Security scanning

### Key Commands
```bash
# Verify GPG signing
git log --show-signature

# Package extension
cd extension.chrome && zip -r ../semantest-v1.0.3.zip *
```

---

## 🏗️ System Architect Card (Sophia - if present)

### Your Mission
Design scalable architecture for handling 500+ image downloads efficiently.

### Quick Orientation
```bash
# Start here
/model opus
/sc:analyze ./semantest --ultrathink --focus architecture

# Review
- Event-driven architecture
- Queue design patterns
- Scalability considerations
```

### Your Analysis Areas
1. Download queue architecture
2. Error handling strategies
3. Performance optimization
4. Future scalability (500+ images)

### Key Decisions
- Queue implementation (in-memory vs persistent)
- Concurrent download limits
- Retry strategies
- Progress tracking mechanism

---

## 🎯 Common Goals for All

### Project Context
- **What**: Automating ChatGPT image generation for graphic novel
- **Who**: rydnr (creating 500+ strip graphic novel)
- **Why**: Manual generation would take months
- **Current**: v1.0.2 generates images, need download feature

### Quality Standards
- Always use Opus model (quality first!)
- GPG sign all commits
- Use TDD emojis when applicable
- Document decisions in journal.org

### Communication
- Report progress to PM regularly
- Use `/sc:` commands for all work
- Ask for help when blocked
- Share discoveries with team

### Success Looks Like
- Images download reliably to chosen folders
- Users have clear feedback on progress
- System handles errors gracefully
- Code is well-tested and documented

Welcome to Semantest! Let's build something amazing together! 🚀