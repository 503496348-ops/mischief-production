# Claude Code → Hermes Translation Map

When importing skills from Claude Code / Superpowers ecosystem, replace platform-specific references so the skills work natively in Hermes.

## Replacement Table

| Pattern | Replacement | Scope |
|---------|-------------|-------|
| `Claude Code` | `Hermes Agent` | Product name in docs/descriptions |
| `CLAUDE.md` | `AGENTS.md` | Configuration file references |
| `.claude/` | `.hermes/` | Directory path references |
| `/dispatch` | `delegate_task` | Slash command → Hermes tool |
| `/skill` | `skill_view` | Slash command → Hermes tool |
| `/sdd` | `skill_view("sp-subagent-driven-development")` | Slash command → skill reference |
| `/review` | `代码审查` | Slash command → natural language |
| `/brainstorm` | `skill_view("sp-brainstorming")` | Slash command → skill reference |
| `/verify` | `验证步骤` | Slash command → natural language |
| `/plan` | `skill_view("sp-writing-plans")` | Slash command → skill reference |
| `anthropic` | KEEP (attribution) | References to Anthropic best practices docs |

## Automated Replacement Script

```python
import os, re

skills_dir = "/root/.hermes/skills"
external_prefixes = ("sp-", "as-", "mp-", "ecc-", "awc-")

replacements = [
    (r'\bClaude Code\b', 'Hermes Agent'),
    (r'\bCLAUDE\.md\b', 'AGENTS.md'),
    (r'\.claude/', '.hermes/'),
    (r'/dispatch\b', 'delegate_task'),
    (r'/skill\b', 'skill_view'),
    (r'/sdd\b', 'skill_view("sp-subagent-driven-development")'),
    (r'/review\b', '代码审查'),
    (r'/brainstorm\b', 'skill_view("sp-brainstorming")'),
    (r'/verify\b', '验证步骤'),
    (r'/plan\b', 'skill_view("sp-writing-plans")'),
]

stats = {"files": 0, "total": 0}
for name in sorted(os.listdir(skills_dir)):
    if not name.startswith(external_prefixes):
        continue
    skill_path = os.path.join(skills_dir, name)
    if not os.path.isdir(skill_path):
        continue
    for root, dirs, files in os.walk(skill_path):
        for f in files:
            if f.endswith(('.pyc', '.pyo', '.png', '.jpg', '.gif')):
                continue
            fpath = os.path.join(root, f)
            try:
                with open(fpath, 'r', errors='ignore') as fh:
                    content = fh.read()
            except:
                continue
            original = content
            file_n = 0
            for old, new in replacements:
                content, n = re.subn(old, new, content)
                file_n += n
            if content != original:
                with open(fpath, 'w') as fh:
                    fh.write(content)
                stats["files"] += 1
                stats["total"] += file_n

print(f"Modified {stats['files']} files, {stats['total']} replacements")
```

## What NOT to Replace

| Pattern | Why Keep |
|---------|----------|
| `anthropic` in reference docs | Authorship attribution for best practices guides |
| `@obra`, `@addyosmani`, `@mattpocock` | Author names in content — these are external reference tools, not 竞品融合 |
| `/tmp/brainstorm` | Filesystem path, not a slash command |
| `Superpowers` in sp-* skill content | Brand name of the imported skill framework — acceptable in reference materials |
| `mcp__*` tool patterns | May be valid MCP tool references if Hermes has MCP configured |

## Key Distinction: External Reference vs 竞品融合

| | External Skill Reference | 竞品融合 |
|---|---|---|
| **Purpose** | Use third-party dev tools as-is | Absorb competitor capabilities into our products |
| **Author names** | KEEP (attribution) | REMOVE (our product now) |
| **Brand names** | KEEP (framework identity) | REPLACE (our brand) |
| **Platform deps** | REPLACE (make it work in Hermes) | N/A (already our code) |
| **GitHub URLs** | KEEP (source of truth) | REMOVE (our repo now) |
| **Example** | sp-* skills from Superpowers | SkillSpector → hermes-security-suite |

## Verification

After replacement, run residual scan:

```python
import os, re

patterns = [
    (r'\bClaude Code\b', "Claude Code"),
    (r'\bCLAUDE\.md\b', "CLAUDE.md"),
    (r'\.claude/', ".claude/"),
    (r'/dispatch\b', "/dispatch"),
    (r'/sdd\b', "/sdd"),
    (r'/brainstorm\b', "/brainstorm"),
]

for name in sorted(os.listdir(skills_dir)):
    if not name.startswith(external_prefixes):
        continue
    # ... scan and report any remaining hits
```

**Zero hits** for platform-specific patterns is the only acceptable result.
False positives like `/tmp/brainstorm` (filesystem paths) are acceptable.
