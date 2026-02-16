# YAML Frontmatter Specification

## Required Fields

```yaml
---
name: skill-name-in-kebab-case
description: What it does and when to use it. Include specific trigger phrases.
---
```

### name (required)

- kebab-case only
- No spaces or capitals
- Should match folder name
- Cannot use `claude` or `anthropic` as prefix (reserved)

### description (required)

Must include BOTH:
1. What the skill does (What)
2. When to use it (When / trigger conditions)

Constraints:
- Under 1024 characters
- No XML tags (`<` `>`)
- Include specific tasks users might say
- Mention file types if relevant

Structure: `[What it does] + [When to use it] + [Key capabilities]`

## Optional Fields

### license

- Use if making skill open source
- Example: `MIT`, `Apache-2.0`

### compatibility

- 1-500 characters
- Indicates environment requirements (intended product, required system packages, network access needs, etc.)

### allowed-tools

- Restrict tool access
- Example: `"Bash(python:*) Bash(npm:*) WebFetch"`

### metadata

- Any custom key-value pairs
- Recommended: `author`, `version`, `mcp-server`

```yaml
metadata:
  author: Company Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [project-management, automation]
```

## Description Examples

### Good

```yaml
# Specific and actionable
description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".

# Includes trigger phrases
description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".

# Clear value proposition
description: End-to-end customer onboarding workflow for PayFlow. Handles account creation, payment setup, and subscription management. Use when user says "onboard new customer", "set up subscription", or "create PayFlow account".
```

### Bad

```yaml
# Too vague
description: Helps with projects.

# Missing triggers
description: Creates sophisticated multi-page documentation systems.

# Too technical, no user triggers
description: Implements the Project entity model with hierarchical relationships.
```

## Security Constraints

### Allowed
- Any standard YAML types (strings, numbers, booleans, lists, objects)
- Custom metadata fields
- Long descriptions (up to 1024 characters)

### Forbidden
- XML angle brackets (`<` `>`) - frontmatter appears in system prompt, malicious content could inject instructions
- Code execution in YAML (uses safe YAML parsing)
- Skills named with `claude` or `anthropic` prefix (reserved)

## Full Frontmatter Template

```yaml
---
name: skill-name
description: [required description]
license: MIT
compatibility: Claude.ai, Claude Code
metadata:
  author: Your Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [tag1, tag2]
---
```
