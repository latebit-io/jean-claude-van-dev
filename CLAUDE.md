# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code plugin that provides Go-focused agents, skills, rules, and hooks. It acts as both a plugin and a self-hosted marketplace. There is no build step or runtime code — the entire plugin is markdown and JSON configuration.

## Architecture

- `.claude-plugin/plugin.json` — Plugin manifest. Lists agents and skills paths. Bump `version` on releases.
- `.claude-plugin/marketplace.json` — Marketplace manifest. Enables `claude plugin marketplace add latebit-io/jean-claude-van-dev` installation flow. The `plugins[0].source` of `"./"` means the plugin root is the repo root.
- `rules/_root.md` — Global rules injected into every Claude interaction when the plugin is active. This is the most impactful file — changes here affect all agents and skills.
- `agents/*.md` — Subagent definitions. YAML frontmatter controls `name`, `description`, `tools`, and `model`. The markdown body is the agent's system prompt.
- `skills/*/SKILL.md` — Slash command definitions. YAML frontmatter controls `name`, `description`, `user-invocable`, and `allowed-tools`. The markdown body is the skill's execution instructions.
- `hooks/hooks.json` — PostToolUse hooks that run shell commands after Write/Edit operations. Currently runs `gofmt` and `go vet` on `.go` files.

## Installation

### Via marketplace

```bash
claude plugin marketplace add latebit-io/jean-claude-van-dev
claude plugin install jean-claude-van-dev@jean-claude-van-dev
```

### Manual (local directory)

```bash
# Clone the repo
git clone https://github.com/latebit-io/jean-claude-van-dev.git

# Option 1: Use for a single session
claude --plugin-dir /path/to/jean-claude-van-dev

# Option 2: Install permanently for the current project
claude plugin install /path/to/jean-claude-van-dev --scope project

# Option 3: Install permanently for all projects
claude plugin install /path/to/jean-claude-van-dev --scope user
```

### Symlink into ~/.claude

Symlinks agents, skills, rules, and hooks directly into `~/.claude/` so they apply globally. Updates with `git pull`.

```bash
git clone https://github.com/latebit-io/jean-claude-van-dev.git ~/.jean-claude-van-dev
~/.jean-claude-van-dev/install.sh
```

The script is safe to re-run — it replaces existing symlinks and refuses to overwrite real directories.

## Validation

```bash
# Validate JSON files
jq empty .claude-plugin/plugin.json .claude-plugin/marketplace.json hooks/hooks.json

# Validate plugin structure
claude plugin validate .
```

## Conventions

- Agent frontmatter uses `tools:` as a comma-separated list (e.g., `tools: Read, Grep, Glob, Bash`)
- Read-only agents (architect, reviewer, refactorer) intentionally omit Write/Edit/Bash tools
- Agents that need to run commands (debugger, tester) include Bash
- All agents use `model: sonnet`
- Skills use `allowed-tools:` in frontmatter and set `user-invocable: true`
- Hooks filter `.go` files with a shell `case` statement to avoid running on non-Go edits
