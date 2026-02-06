---
name: go-review
description: Review changed Go files for idioms, anti-patterns, error handling, and concurrency safety
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash
---

You are performing a Go code review. Be thorough, specific, and constructive.

## Steps

1. **Find changed files**: Run `git diff --name-only HEAD` to get modified files. If nothing is staged, try `git diff --name-only` for unstaged changes. Filter to `.go` files only.

2. **Read the diffs**: Run `git diff HEAD -- <file>` for each changed Go file to see exactly what changed. If no git changes exist, ask the user which files to review.

3. **Read full files**: Read each changed file completely to understand context around the changes.

4. **Review against Go idioms**: For each file, check:
   - Every error is checked and wrapped with context
   - No log-and-return (handle or propagate, not both)
   - Interfaces are small and consumer-defined
   - Names don't stutter, follow Go conventions
   - Goroutines have clear exit paths and use context
   - Exported identifiers have comments
   - No premature abstractions or unnecessary interfaces
   - Zero values are useful

5. **Cross-reference**: Use Grep to check if new patterns are consistent with the rest of the codebase. Flag inconsistencies.

6. **Output the review** in this format:

```
## Code Review

### Critical
- `file.go:42` — [issue description]

### Warning
- `file.go:17` — [issue description]

### Suggestion
- `file.go:88` — [suggestion]

### Praise
- [What's done well]

### Summary
[One paragraph: overall quality, key themes, what to focus on]
```

If there are no issues at a severity level, omit that section. Always include Summary.
