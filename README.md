# jean-claude-van-dev

A full team of world-class Go staff engineers for Claude Code.

Built on the principles of Pike, Cheney, Ryer, and Kennedy — simplicity, readability, and code that earns every line.

## Install

```bash
# Add the marketplace (one-time)
claude plugin marketplace add latebit-io/jean-claude-van-dev

# Install the plugin
claude plugin install jean-claude-van-dev@jean-claude-van-dev
```

Or symlink into `~/.claude` for global use across all projects:

```bash
git clone https://github.com/latebit-io/jean-claude-van-dev.git ~/.jean-claude-van-dev
~/.jean-claude-van-dev/install.sh
```

Or for local development:

```bash
claude --plugin-dir /path/to/jean-claude-van-dev
```

## What You Get

### Rules

Core Go engineering principles applied to every interaction — error handling, interface design, package structure, concurrency, naming, testing, and performance. These shape how Claude writes Go code at all times.

### Agents

Five specialized engineering roles, invoked as subagents:

| Agent | Role | Tools |
|-------|------|-------|
| `go-architect` | Package design, boundaries, dependency analysis, API surfaces | Read, Grep, Glob |
| `go-reviewer` | Code review — idioms, error handling, concurrency, naming | Read, Grep, Glob |
| `go-debugger` | Root cause analysis, race detection, profiling, stack traces | Read, Grep, Glob, Bash |
| `go-tester` | Test strategy, coverage gaps, table-driven patterns, benchmarks | Read, Grep, Glob, Bash |
| `go-refactorer` | Simplification, dead code removal, interface extraction | Read, Grep, Glob |

### Skills

Slash commands for common workflows:

| Command | What it does |
|---------|-------------|
| `/jean-claude-van-dev:go-review` | Review changed Go files for idioms and anti-patterns |
| `/jean-claude-van-dev:go-test` | Run tests with coverage analysis and gap identification |
| `/jean-claude-van-dev:go-audit` | Audit error handling, goroutine patterns, and interface design |
| `/jean-claude-van-dev:go-bench` | Run and analyze benchmarks with allocation profiling |

### Hooks

Automatic quality enforcement on every `.go` file edit:

- `gofmt` — auto-format on save
- `go vet` — catch common mistakes immediately

## Structure

```
.claude-plugin/
  plugin.json            # Plugin manifest
  marketplace.json       # Marketplace manifest
agents/
  go-architect.md        # System design advisor
  go-reviewer.md         # Code review specialist
  go-debugger.md         # Root cause analyst
  go-tester.md           # Test strategy advisor
  go-refactorer.md       # Simplification specialist
skills/
  go-review/SKILL.md     # Code review workflow
  go-test/SKILL.md       # Test coverage workflow
  go-audit/SKILL.md      # Codebase audit workflow
  go-bench/SKILL.md      # Benchmark analysis workflow
rules/
  _root.md               # Go staff engineer principles
hooks/
  hooks.json             # gofmt + go vet on edit
```

## License

MIT
