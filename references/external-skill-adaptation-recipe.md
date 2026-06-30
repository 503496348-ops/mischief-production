# External Skill Adaptation Recipe

Step-by-step conversion guide for adapting skills from other AI coding platforms into Hermes-compatible format.

---

## Pre-Flight: Verify the Plan

Before executing any conversion plan, run these checks:

```bash
# 1. Verify repos exist
gh repo view obra/superpowers 2>/dev/null || echo "NOT FOUND"

# 2. Check if it's actually a skill repo (has skills/ or SKILL.md)
gh api repos/obra/superpowers/contents/skills --jq '.[].name' 2>/dev/null | head -10

# 3. Test any "install commands" from the plan in a dry terminal
npx skills add obra/superpowers  # If this errors, the command doesn't exist
```

## Conversion Template

For each skill being converted:

### Step 1: Read Source

```python
from hermes_tools import read_file, terminal

# Read source SKILL.md
r = read_file(f"/tmp/fusion-workspace/{repo}/skills/{skill_name}/SKILL.md")
# If cached, use terminal fallback:
r = terminal(f"cat /tmp/fusion-workspace/{repo}/skills/{skill_name}/SKILL.md")
content = r["output"] if "output" in r else r["content"]
```

### Step 2: Strip Source Frontmatter

```python
lines = content.split('\n')
fm_end = 0
for i, line in enumerate(lines):
    if i == 0 and line.strip() == '---':
        continue
    if line.strip() == '---':
        fm_end = i
        break
body = '\n'.join(lines[fm_end + 1:])
```

### Step 3: Build Hermes Frontmatter

```python
triggers = ["keyword1", "keyword2", "中文触发词", "english trigger"]
triggers_yaml = '\n'.join(f'  - "{t}"' for t in triggers)

adapted = f"""---
name: {skill_name}
description: "From {source_repo} ({skill_name}): brief description of capability"
version: 1.0.0
author: "Hermes Agent (adapted from {source_repo})"
license: MIT
tags: ["{source_repo.split('/')[-1]}", "engineering"]
triggers:
{triggers_yaml}
---

{body}"""
```

### Step 4: Platform Reference Replacement

```python
replacements = [
    ("Claude Code", "Hermes"),
    ("invoke the Skill tool", "use skill_view()"),
    ("Use the `Skill` tool", "use skill_view()"),
    ("your platform's skill-loading mechanism", "skill_view() tool"),
    ("superpowers:", "naughty-studio/"),  # namespace mapping
]

for old, new in replacements:
    adapted = adapted.replace(old, new)
```

### Step 5: Write and Verify

```python
from hermes_tools import write_file

target = f"/root/.hermes/skills/{category}/{skill_name}/SKILL.md"
write_file(target, adapted)

# Verify frontmatter
r = terminal(f"head -3 {target}")
assert "---" in r["output"], f"Missing frontmatter in {target}"
```

### Step 6: Copy Reference Files

```python
# Check for subdirectories
r = terminal(f"find {source_dir} -type f -not -name 'SKILL.md' -not -path '*/.git/*'")
if r["output"].strip():
    terminal(f"cp -r {source_dir}/references {target_dir}/ 2>/dev/null")
    terminal(f"cp -r {source_dir}/scripts {target_dir}/ 2>/dev/null")
    terminal(f"cp -r {source_dir}/templates {target_dir}/ 2>/dev/null")
```

## Verification Script

After converting all skills in a batch:

```python
from hermes_tools import terminal

# 1. Frontmatter check
r = terminal(f"for f in {target_base}/*/SKILL.md; do head -1 \"$f\" | grep -q '---' && echo '✅' || echo '❌ $f'; done")

# 2. Naming conflicts
r = terminal(f"ls -d {target_base}/*/ | xargs -I{{}} basename {{}} | sort | uniq -d")
assert not r["output"].strip(), f"Duplicate names: {r['output']}"

# 3. Trigger overlap (informational, not blocking)
r = terminal(f"grep -rh '  - \"' {target_base}/*/SKILL.md | sort | uniq -d")
# Minor overlaps are acceptable

# 4. Total count
r = terminal(f"ls -d {target_base}/*/ | wc -l")
print(f"Total skills: {r['output'].strip()}")
```

## Common Source Repos and Their Formats

| Platform | Skill Format | Notes |
|----------|-------------|-------|
| obra/superpowers | `skills/<name>/SKILL.md` | Claude Code native, has references/ and scripts/ |
| addyosmani/agent-skills | `skills/<name>/SKILL.md` | Clean format, no extra files |
| mattpocock/skills | `skills/<category>/<name>/SKILL.md` | Nested in categories (engineering/, productivity/) |
| project-codeguard/rules | `skills/<name>/SKILL.md` + `rules/*.md` | Rules as separate files in rules/ subdir |

## Trigger Keyword Strategy

Good triggers mix Chinese and English, covering:
- **Action verbs**: 创建, 设计, 优化, 审查, 部署
- **Domain nouns**: API, 安全, 性能, CI/CD
- **User phrases**: what the user would actually say

Bad triggers:
- Too generic: "代码", "开发", "项目"
- Too specific: "codeguard-0-input-validation-injection.md"
- Platform-specific: "npx skills add"
