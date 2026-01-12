---
description: Create a pull request with structured sections for reviewers and clients
argument-hint: "[optional considerations or context for the PR]"
---

Create a pull request from the current branch to the main branch.

## Steps:

### 1. **Gather context**:
   - Get current branch: `git branch --show-current`
   - Find main branch (usually `main` or `master`)
   - See differing commits: `git log main..HEAD --oneline`
   - Review changes: `git diff main...HEAD`
   - Consider any extra context: $ARGUMENTS

### 2. **Clarify if needed**:
   - If changes are unclear, ask the user before proceeding

### 3. **Create PR** with `gh pr create`:

```
gh pr create --title "<concise title>" --body "$(cat <<'EOF'
**Target:** `<target_branch>`

## Summary of Changes
- <factual, technical description>
- ...

## Test Plan
- [ ] <verification step>
- ...

## Resumen para el cliente
```
- <cambio en español, sin detalles técnicos>
- ...
```
EOF
)"
```

## Guidelines:

**Summary of Changes** (English)
- Factual, no opinions - just state what changed
- Technical but clear - help reviewers focus
- Keep it brief and scannable

**Test Plan**
- Checklist with concrete verification steps
- Cover main affected flows

**Resumen para el cliente** (Spanish)
- Wrap in markdown code block (```) for easy copy-paste from GitHub
- Only user-facing changes
- Simple language, no technical details
- Ready to copy-paste to client changelogs

**Length:** Keep all sections proportional to the actual changes. Small PR = short sections.

## Before creating:
- Push branch if needed: `git push -u origin <branch>`
- Return the PR URL when done
