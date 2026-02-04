---
description: Review current git changes and create a properly formatted commit
argument-hint: "[optional commit message]"
---

Review the current git changes and create a well-formatted commit message following the project's conventions.

Steps to follow:

1. **Analyze current changes**:
   - Check `git status` for changed files
   - Review `git diff` for actual changes  
   - Look at recent commits with `git log --oneline -5` for format patterns

2. **Create commit message**:
   - Follow conventional commits format: `type(scope): description`
   - Use types: feat, fix, refactor, test, docs, style, chore
   - Keep first line under 72 characters
   - Add bullet points for multiple significant changes
   - Use imperative mood (add, fix, update - not adds, fixed, updated)

3. **Execute commit**:
   - Stage all relevant files with `git add`
   - Create commit with generated message

If arguments are provided ($ARGUMENTS), use that as a guide or basis for the commit message.

Focus on being concise, clear, and following the existing commit style in the repository.

Important considerations:

- If commit fails due to pre-commit hooks, commit will NOT be created. So we need to add changed files and commit again.
