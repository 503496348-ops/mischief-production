# Internal/External Skill Priority Markers

When external imported skills overlap with existing internal Hermes skills, add explicit priority markers so future sessions know which skill takes precedence.

## Step 1 · Identify Real Overlaps

Keyword-based detection produces false positives ("design" matches poster design AND code architecture). Always do manual domain grouping:

```python
# Group by functional domain, not by keyword
domains = {
    "TDD": ["sp-test-driven-development", "as-test-driven-development", "mp-tdd"],
    "调试": ["sp-systematic-debugging", "as-debugging-and-error-recovery", "mp-diagnosing-bugs"],
    # ...
}
```

## Step 2 · Determine Priority

| Scenario | Priority Rule |
|----------|--------------|
| Internal skill exists + external overlaps | Internal wins (Hermes native, already tested) |
| Only external skills in domain | Keep best one, delete rest |
| Both internal and external are complementary | Keep both, mark external as supplementary |

## Step 3 · Mark External Skills (Supplementary)

Add a priority note at the TOP of the external skill's YAML frontmatter, before the `triggers:` line:

```yaml
---
name: as-frontend-ui-engineering
description: "Builds production-quality UIs..."
# 优先级：Hermes内部frontend-design负责设计审美与视觉品质；本skill作为Google工程规范补充，覆盖性能优化、可访问性、组件架构等工程维度。
triggers:
  - as frontend
  - as ui engineering
---
```

The `#` comment in YAML is valid and won't break parsing.

## Step 4 · Mark Internal Skills (Primary)

Append a one-line note to the internal skill's `description:` field:

```yaml
description: "Create distinctive, production-grade frontend interfaces... 本skill为Hermes原生主技能，优先级高于外部引入的as-frontend-ui-engineering。"
```

## Step 5 · Verify

After marking:
1. Check YAML validity: `yaml.safe_load()` on each modified frontmatter
2. Check loadability: `skill_view(name=...)` on both internal and external
3. No circular references: external skill shouldn't say "see internal" AND internal say "see external"

## Real-World Example: 3 Pairs (2026-06-30)

| Domain | Internal (Primary) | External (Supplementary) |
|--------|-------------------|-------------------------|
| 前端UI | `frontend-design` (设计审美) | `as-frontend-ui-engineering` (Google工程规范) |
| Docker | `devops-toolkit` (运维操作) | `ecc-docker-patterns` (模式参考) |
| GitHub | `github-pr-workflow` (CLI实战) | `ecc-github-ops` (工作流模式) |

**Note**: TDD, debugging, subagent, planning, git — no internal skills existed, so external skills became primary by default. No markers needed.
