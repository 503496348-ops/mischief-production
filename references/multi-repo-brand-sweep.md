# Multi-Repo Brand Sweep Procedure

When cleaning brand references across 10+ repos, use this systematic approach.

## Step 1: Clone All Repos

```bash
cd /tmp && mkdir brand-fix && cd brand-fix
for repo in repo1 repo2 repo3; do
  gh repo clone "org/$repo" 2>&1 | tail -1
done
```

**Pitfall**: `gh repo clone` does NOT support `--depth`. Use `-- --depth 1` to pass git flags:
```bash
gh repo clone org/repo -- --depth 1
```

## Step 2: Scan All Repos

```python
import os, re

patterns = [
    (r'花叔', 'author'),
    (r'HuaShu|Huashu|huashu', 'brand'),
    (r'Claude Code|claude code', 'platform'),
    (r'~/.claude/', 'path'),
    # ... add all known third-party patterns
]

hits = []
for repo_dir in os.listdir(base):
    for root, dirs, files in os.walk(os.path.join(base, repo_dir)):
        dirs[:] = [d for d in dirs if d not in ['.git']]
        for f in files:
            if f.endswith(('.pyc', '.png', '.jpg')): continue
            content = open(os.path.join(root, f), errors='ignore').read()
            for pat, label in patterns:
                if re.search(pat, content, re.IGNORECASE):
                    hits.append((repo_dir, f, label))
```

## Step 3: Batch Replace

```python
# Global replacements (apply to ALL repos)
global_fixes = [
    ("OldAuthorName", "NewTeamName"),
    ("OldBrand", "NewBrand"),
]

# Per-repo specific fixes
repo_specific = {
    "repo-a": {"file.md": [("specific_old", "specific_new")]},
}
```

**Pitfall**: Binary files (PNG, MP3) contain byte patterns that look like text matches. Always skip binary extensions.

**Pitfall**: CSS `cursor:` property and JS `let cursor = 0` match `cursor` regex. Filter by checking context.

**Pitfall**: API endpoints in config files are functional — keep them. Only replace brand references in user-visible text.

## Step 4: Verify Zero Residual

Target: ZERO hits for brand/author patterns across all repos.

## Step 5: Push All Changed Repos

```python
for repo_dir in os.listdir(base):
    result = terminal("git status --short", workdir=repo_path)
    if result['output'].strip():
        terminal("git add -A", workdir=repo_path)
        terminal(f'git commit -m "🏷️ 品牌归属统一: {team_name}"', workdir=repo_path)
        terminal("git push", workdir=repo_path)
```

## Bitable Product Registry Update

After pushing repos, update the product tracking Bitable:

```bash
lark-cli base +record-upsert \
  --base-token <BASE_TOKEN> \
  --table-id <TABLE_ID> \
  --record-id <RECORD_ID> \
  --json '{"字段名": "新值", "更新日期": "2026-06-19"}' \
  --as user
```

**Pitfall**: `+record-update` does NOT exist. Use `+record-upsert` with `--record-id` for updates.

**Pitfall**: Date fields use `"YYYY-MM-DD"` format for simple date values.

**Pitfall**: Select fields use string values like `"一致"`, not arrays. Multi-select uses `["Tag A", "Tag B"]`.
