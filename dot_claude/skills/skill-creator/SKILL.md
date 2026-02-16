---
name: skill-creator
description: Interactive guide for creating new Claude skills. Walks through use case definition, folder structure, frontmatter generation, instruction writing, and validation. Use when user says "create a skill", "build a skill", "new skill", "skill template", or "help me make a skill".
---

# Skill Creator

Interactive guide for creating new Claude skills from scratch.

## Important

- A skill is packaged as a folder containing `SKILL.md`
- Folder names must be kebab-case (e.g., `my-cool-skill`)
- `SKILL.md` is case-sensitive (`skill.md` or `SKILL.MD` will not work)
- Do not include `README.md` inside the skill folder (put documentation in `SKILL.md` or `references/`)

## Instructions

### Step 1: Define Use Cases

Identify 2-3 concrete use cases the skill should enable.

Ask the user:
- What do you want to accomplish?
- What multi-step workflows does this require?
- Which tools are needed? (Claude built-in or MCP)
- What domain knowledge or best practices should be embedded?

Use case definition format:

```
Use Case: [Use Case Name]
Trigger: User says "[trigger phrase]"
Steps:
  1. [Step 1]
  2. [Step 2]
  3. [Step 3]
Result: [Expected result]
```

Determine the skill category:
- **Category 1: Document & Asset Creation** - Generate consistent, high-quality output
- **Category 2: Workflow Automation** - Automate multi-step repeatable processes
- **Category 3: MCP Enhancement** - Add workflow guidance on top of MCP tool access

### Step 2: Create Folder Structure

Create the following structure:

```
your-skill-name/           # kebab-case required
├── SKILL.md                # Required - main skill file
├── scripts/                # Optional - executable code
├── references/             # Optional - reference documentation
└── assets/                 # Optional - templates, icons, etc.
```

Naming rules:
- kebab-case only: `notion-project-setup`
- No spaces: `Notion Project Setup`
- No underscores: `notion_project_setup`
- No capitals: `NotionProjectSetup`
- Cannot use `claude` or `anthropic` as prefix (reserved)

### Step 3: Write YAML Frontmatter

Write YAML frontmatter at the top of `SKILL.md`.

Required fields:

```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [specific phrases].
---
```

Description field structure:

```
[What it does] + [When to use it (trigger conditions)] + [Key capabilities]
```

Good description examples:

```yaml
# Specific and actionable
description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".

# Includes trigger phrases
description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".
```

Bad description examples:

```yaml
# Too vague
description: Helps with projects.

# Missing triggers
description: Creates sophisticated multi-page documentation systems.

# Too technical, no user triggers
description: Implements the Project entity model with hierarchical relationships.
```

Frontmatter security constraints:
- No XML angle brackets (`<` `>`)
- Description must be under 1024 characters
- No code execution in YAML

See `references/frontmatter-spec.md` for full specification.

### Step 4: Write Instructions

Follow the three-level Progressive Disclosure system:

- **Level 1 (YAML frontmatter)**: Always loaded in system prompt. Minimum info for Claude to decide when to use the skill
- **Level 2 (SKILL.md body)**: Loaded when skill is relevant. Full instructions and guidance
- **Level 3 (Linked files)**: Additional files in the skill directory. Loaded only as needed

Recommended body structure:

```markdown
# Skill Name

## Instructions

### Step 1: [First Major Step]
Clear explanation of what happens.

### Step 2: [Next Step]
...

## Examples

### Example 1: [Common scenario]
User says: "..."
Actions:
1. ...
2. ...
Result: ...

## Troubleshooting

### Error: [Common error]
**Cause:** [Why it happens]
**Solution:** [How to fix]
```

Best practices:
- Write specific, actionable instructions
- Include error handling
- Reference bundled resources clearly
- Keep SKILL.md under 5,000 words; move details to `references/`

See `references/skill-template.md` for a copy-paste template.

### Step 5: Test and Validate

Validate the skill from three perspectives:

**1. Triggering tests**
- Triggers on obvious tasks
- Triggers on paraphrased requests
- Does NOT trigger on unrelated topics

**2. Functional tests**
- Valid outputs generated
- API calls succeed
- Error handling works
- Edge cases covered

**3. Performance comparison**
- Compare results with and without the skill

See `references/checklist.md` for the full checklist.

## Examples

### Example 1: Zenn Article Writer Skill

User says: "Create a skill for writing Zenn articles"

Actions:
1. Define use cases (draft creation, frontmatter generation)
2. Create `zenn-article-writer/SKILL.md`
3. Include Zenn-specific trigger phrases in frontmatter
4. Add article template and textlint rules as references

Result: A skill that consistently guides Zenn article creation

### Example 2: MCP Enhancement Skill

User says: "Build a workflow skill for Notion MCP"

Actions:
1. Review MCP tool list and define use cases
2. Create `notion-workflow/SKILL.md`
3. Document MCP call sequences as step-by-step instructions
4. Include error handling and fallbacks

Result: A workflow skill that leverages Notion MCP effectively

## Troubleshooting

### Error: "Could not find SKILL.md in uploaded folder"
**Cause:** File is not named exactly `SKILL.md`
**Solution:** Rename to `SKILL.md` (case-sensitive)

### Error: "Invalid frontmatter"
**Cause:** YAML formatting issue
**Solution:** Ensure `---` delimiters are present. Close all quotes. Check indentation

### Error: "Invalid skill name"
**Cause:** Name contains spaces or capitals
**Solution:** Use kebab-case (e.g., `my-cool-skill`)

### Skill doesn't trigger
**Cause:** Description is too vague or missing trigger phrases
**Solution:** Add specific trigger phrases to the description field

### Skill triggers too often
**Cause:** Description scope is too broad
**Solution:** Add negative triggers (e.g., "Do NOT use for ...") or narrow the scope
