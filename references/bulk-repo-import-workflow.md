# Bulk Repo Import: Symlink + Triggers + Conflict Audit

When importing **entire external skill repos** into Hermes as-is (not merging into one target), use this workflow. Distinct from fusion — you're importing whole collections, preserving source identity.

## Step 1 · Clone + Prefix

Clone each repo to `~/.hermes/external-skills/` with a short alias. Symlink all SKILL.md-containing directories into `~/.hermes/skills/` with a **source prefix** to avoid name collisions:

```bash
# Clone
mkdir -p ~/.hermes/external-skills
git clone https://github.com/<org>/<repo> ~/.hermes/external-skills/<alias>

# Symlink with prefix (as- for agent-skills, sp- for superpowers, etc.)
for d in ~/.hermes/external-skills/<alias>/skills/*/; do
  name=$(basename "$d")
  ln -s "$d" ~/.hermes/skills/<prefix>-${name}
done
```

**Prefix convention**: 2-3 letter abbreviation of source repo + hyphen. Examples:
- `sp-` = superpowers
- `as-` = agent-skills
- `mp-` = mattpocock/skills
- `ecc-` = everything-claude-code
- `awc-` = ai-website-cloner

## Step 2 · Bulk Triggers Injection

External repos rarely have Hermes-compatible `triggers` fields. Inject them in batch:

```python
import os, re, yaml

skills_dir = "/root/.hermes/skills"
prefix = "sp-"  # Process one prefix at a time

for name in sorted(os.listdir(skills_dir)):
    if not name.startswith(prefix):
        continue
    skill_md = os.path.join(skills_dir, name, "SKILL.md")
    if not os.path.exists(skill_md):
        continue
    with open(skill_md) as f:
        content = f.read()

    # Skip if already has triggers
    if re.search(r'^triggers:', content, re.MULTILINE):
        continue

    # Extract name from frontmatter
    m = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not m:
        continue
    meta = yaml.safe_load(m.group(1))
    skill_name = meta.get("name", name)

    # Generate triggers from name + description
    desc = meta.get("description", "")
    words = re.findall(r'[a-z]+', skill_name.lower())
    triggers = words[:4] + ["when", "starting"]  # Minimal fallback

    # Insert triggers after description line
    trigger_yaml = yaml.dump({"triggers": triggers}, default_flow_style=False).strip()
    content = content.replace(
        f'description: "{desc}"',
        f'description: "{desc}"\n{trigger_yaml}'
    )
    with open(skill_md, "w") as f:
        f.write(content)
```

**Quality gate**: After injection, verify every skill loads via `skill_view()`. A missing or malformed triggers field causes silent load failure.

## Step 3 · Cross-Repo Conflict Audit

When importing 3+ repos, functional overlaps are **inevitable**. Audit in two passes:

### Pass 1 — Keyword overlap detection (automated)

Parse all frontmatter, group by trigger keyword. Flag any trigger appearing in 3+ skills. Output sorted list of conflicts with skill names.

### Pass 2 — Functional domain grouping (manual judgment)

Group overlapping skills into domains (TDD, debugging, code review, planning, git, security, API design, etc.). For each domain with 2+ skills:

| Decision | When | Example |
|----------|------|---------|
| **Keep primary, delete others** | Skills are near-identical | 3 TDD skills → keep base repo's |
| **Keep complementary** | Skills address different facets | security-hardening (broad) + security-review (audit checklist) |
| **Keep with priority tag** | Both valuable but overlapping | Mark primary in SKILL.md description |

### Resolution priority (unless user specifies otherwise)

1. **Base repo** (the "foundation" layer) wins for core workflow skills (TDD, debugging, planning, code review, git)
2. **Enhancement repo** wins for specialized engineering norms (security, performance, API design)
3. **Tool/specialized repo** provides unique domain patterns only (FastAPI, Docker, MCP)

### Real-world example: 5-repo import (2026-06-30)

Repos imported: superpowers(14), agent-skills(22), mattpocock(12), ECC(11), ai-website-cloner(1)

**Functional domains with conflicts found (9 domains):**

| Domain | Kept | Deleted | Reason |
|--------|------|---------|--------|
| TDD | sp-test-driven-development | as-test-driven-development, mp-tdd | Superpowers base wins |
| Code Review | sp-requesting/receiving-code-review | as-code-review-and-quality | Superpowers flow covers it |
| Debugging | sp-systematic-debugging | as-debugging-and-error-recovery, mp-diagnosing-bugs | Superpowers base wins |
| Task Planning | sp-writing-plans, mp-to-prd | as-planning-and-task-breakdown, mp-to-issues | mp-to-prd has unique value (conversation→PRD) |
| Git | sp-finishing-branch, sp-worktrees, mp-resolving-merge | as-git-workflow-and-versioning | Superpowers + Mattpocock complementary |
| Security | as-security-and-hardening | ecc-security-review | Agent-Skills more comprehensive |
| API Design | as-api-and-interface-design | ecc-api-design | Agent-Skills more comprehensive |
| SubAgent | sp-dispatching, sp-subagent-driven | mp-implement | Superpowers base covers it |
| Code Simplification | as-code-simplification + mp-improve-codebase-architecture | (none) | Complementary: refactoring vs architecture |

**Result**: 60 → 50 external skills after removing 11 duplicates. Total with 103 internal = 153 skills.

## Step 4 · Verify + Report

After conflict resolution:
1. Count remaining skills per source (before/after)
2. List every deleted skill with reason
3. Spot-check 3+ skills via `skill_view()` across different sources
4. Report total skill count (external + internal)

## Pitfalls

### Symlinks survive git operations
Symlinked skills are NOT git-tracked in the skills directory. If someone runs `git clean -fd` in `~/.hermes/skills/`, all symlinks vanish. Keep the clone in `external-skills/` as the source of truth.

### Triggers injection can break YAML
If the original SKILL.md has unusual YAML (multi-line strings, nested objects, special characters), the regex-based injection may corrupt the frontmatter. Always validate with `yaml.safe_load()` after injection.

### Keyword-based overlap detection produces false positives
"design" matches both poster design and code architecture. "build" matches both MCP server building and domain modeling. Always do Pass 2 (manual domain grouping) — don't auto-delete based on keyword overlap alone.

### Naming prefix collisions
If two repos both have a skill called "debugging", prefixes prevent directory collision (`sp-debugging` vs `as-debugging`), but Hermes may still surface both on the same trigger. The conflict audit (Step 3) must handle this.

### execute_code terminal() returns dict with "output" key
When using `terminal()` inside `execute_code`, the return dict has key `"output"` not `"stdout"`. If you get `KeyError: 'output'`, check the actual key names returned.
