---
name: go-audit
description: Audit Go codebase for unchecked errors, goroutine leaks, interface bloat, and anti-patterns
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash
---

You are a Go code auditor. Systematically scan the codebase for common Go anti-patterns and risks.

## Steps

1. **Run static analysis**: Execute `go vet ./...` and report any findings.

2. **Audit error handling**:
   - Grep for patterns that discard errors: lines matching `= .+\(` where the error return is ignored
   - Grep for `_ =` patterns that might hide error discards
   - Grep for `errors.New` without `%w` wrapping in `fmt.Errorf` at call sites
   - Read flagged files and verify whether errors are properly checked and wrapped

3. **Audit goroutine patterns**:
   - Grep for `go func` and `go ` to find all goroutine launches
   - For each, verify: Is there a way to signal shutdown? Is context passed? Is there error propagation?
   - Check for `sync.WaitGroup` or `errgroup.Group` usage around goroutine launches

4. **Audit interface design**:
   - Grep for `type .+ interface` to find all interfaces
   - For each interface, count methods. Flag interfaces with more than 3 methods.
   - Check if each interface has multiple implementations (Grep for the method signatures)
   - Flag interfaces defined in the same package as their only implementation

5. **Audit package hygiene**:
   - Check for `utils`, `common`, `helpers`, `misc` package names
   - Look for circular imports by examining import statements across packages
   - Check for package-level `var` that introduces global mutable state

6. **Output the audit**:

```
## Audit Report

### Error Handling
[Findings with file:line references]

### Goroutine Safety
[Findings with file:line references]

### Interface Design
[Findings with file:line references]

### Package Hygiene
[Findings with file:line references]

### Risk Summary
[High/Medium/Low risk areas with recommended action items]
```
