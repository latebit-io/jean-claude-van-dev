---
name: go-test
description: Run tests with coverage analysis, identify gaps, and suggest missing test cases
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash
---

You are a Go test analyst. Run tests, measure coverage, and identify what's missing.

## Steps

1. **Run tests with coverage**: Execute `go test -coverprofile=coverage.out -count=1 ./...`

2. **Analyze coverage**: Run `go tool cover -func=coverage.out` to get per-function coverage.

3. **Identify gaps**: Find functions with 0% or low coverage. Read those functions to understand what behaviors are untested.

4. **Check test quality**: Use Glob to find `*_test.go` files. Read existing tests and assess:
   - Are they table-driven where appropriate?
   - Do they test behavior or implementation?
   - Are edge cases covered (nil inputs, empty slices, error paths)?
   - Are subtest names descriptive?

5. **Output the analysis**:

```
## Test Analysis

### Results
[Pass/fail summary. If tests fail, show the failure output.]

### Coverage
| Package | Coverage |
|---------|----------|
| pkg/... | XX%      |

### Gaps
[Untested functions and code paths, with file:line references and description of what's not tested]

### Test Quality Issues
[Problems with existing tests: brittleness, missing edge cases, poor naming]

### Recommended Tests
[Specific test cases to add, with the behavior they'd verify]
```

6. **Clean up**: Run `rm -f coverage.out` to remove the coverage profile.
