1|---
2|name: mischief-production
3|description: "顽皮制造 — Fuse multiple external skill repos/sources into an existing skill to create a unified, more capable version. Use when the user says 'merge these skills', 'combine X into Y', 'absorb the best parts of A/B/C into Z', 'upgrade this skill with features from those repos', or provides multiple GitHub URLs and asks to integrate them into a single skill. Also triggers on 'audit these skills and see if they can enhance ours'."
4|---
5|
6|# 顽皮制造 · Mischief Production
7|
8|Merge multiple external skill sources (GitHub repos, local directories, reference docs) into an existing target skill, producing a unified version that absorbs the best capabilities of all sources while preserving the target's identity.
9|
10|**When to use**: User provides 2+ external skill sources and wants them merged into an existing skill. Also triggers on: "compare our skills against competitors", "merge these repos into one", "ecosystem audit and upgrade", "对标竞品融合升级".
11|**When NOT to use**: Creating a skill from scratch (→ `skill-creator`), minor patches (→ `skill_manage patch`), eval/regression testing (→ `skill-eval-gate`).
12|
13|---
14|
15|## Core Workflow
16|
17|### Phase 1 · Audit All Sources
18|
19|For each source (GitHub repo, local dir, etc.):
20|
21|1. **Read SKILL.md** — understand the skill's identity, trigger conditions, and core capabilities
22|2. **Catalog assets** — list all `references/`, `scripts/`, `assets/` files with sizes
23|3. **Extract unique value** — what does this source have that others don't?
24|
25|**Output**: A capability matrix comparing all sources across dimensions relevant to the fusion target.
26|
27|Example matrix:
28|
29|| Capability | Source A | Source B | Source C | Target (current) |
30||------------|----------|----------|----------|-------------------|
31|| Style library | ✅ 40 styles | ✅ 12 presets | ❌ | ❌ |
32|| Brand protocol | ✅ 5-step | ❌ | ❌ | ❌ |
33|| Quality checklist | ❌ | ❌ | ✅ 40 items | ❌ |
34|| Export formats | PDF only | PDF+PPTX | HTML only | PDF only |
35|
36|### Phase 2 · Plan the Fusion
37|
38|Decide the fusion strategy based on the capability matrix:
39|
40|1. **Identify the backbone** — which source/target provides the primary structure and identity?
41|2. **Identify absorption targets** — what specific capabilities come from each source?
42|3. **Check for conflicts** — overlapping capabilities with different implementations? Decide which wins.
43|4. **Plan file layout** — map each source's files into the target's directory structure
44|
45|**Common fusion pattern**: Target identity + strongest workflow as backbone + specialized capabilities from others.
46|
47|### Phase 3 · Execute File Merge
48|
49|Copy files from all sources into the target skill directory:
50|
51|```bash
52|# References (merge, don't overwrite existing)
53|cp -rn /source/references/*.md target/references/
54|
55|# Scripts
56|mkdir -p target/scripts && cp -n /source/scripts/* target/scripts/
57|
58|# Assets (templates, fonts, etc.)
59|mkdir -p target/assets && cp -rn /source/assets/* target/assets/
60|```
61|
62|**Rules**:
63|- `-n` (no-clobber) for references — don't overwrite target's existing files
64|- `-rn` for assets — merge directories but don't overwrite existing files
65|- Preserve directory structure from source when it adds organizational value
66|- Check disk space before copying (large skills can be 40MB+)
67|
68|### Phase 4 · Rewrite SKILL.md
69|
70|The fused SKILL.md must:
71|
72|1. **Preserve target's identity** — the name, core philosophy, and design principles stay
73|2. **Add a capability overview table** — show what came from where (traceability)
74|3. **Restructure workflows** — integrate absorbed capabilities as new paths/modes
75|4. **Update the resource map** — the file tree at the bottom must reflect all new files
76|5. **Keep it under 500 lines** — use references/ for deep detail, SKILL.md for navigation
77|
78|**Writing the capability table** (critical for traceability):
79|
80|```markdown
81|## ⚡ Capability Overview
82|
83|| Capability | Source | Key Advantage |
84||------------|--------|---------------|
85|| Original feature | target-skill | Already existed |
86|| New feature A | source-a | 40 style library |
87|| New feature B | source-b | Quality checklist |
88|```
89|
90|**Structural patterns for fused skills**:
91|- **Task routing table** at the top: "If input is X → follow Y path"
92|- **Shared principles first**, then path-specific workflows
93|- **Resource file tree** at the bottom as a map
94|
95|### Phase 5 · Verify Completeness
96|
97|After fusion, run a completeness check:
98|
99|```python
100|# Extract all file references from SKILL.md
101|# Check each one exists in the skill directory
102|# Report missing files as blockers
103|```
104|
105|**Verification checklist**:
106|- [ ] All files referenced in SKILL.md exist on disk
107|- [ ] All referenced scripts are executable (or have clear invocation instructions)
108|- [ ] Templates are complete (not truncated during copy)
109|- [ ] No duplicate files with different content
110|- [ ] Directory structure is clean (no `.git/`, `node_modules/`, temp files)
111|- [ ] Total size is reasonable (flag if >100MB)
112|
113|### Phase 6 · Register and Test
114|
115|1. Verify the skill loads via `skill_view(name=<target>)`
116|2. Check that `linked_files` correctly lists all references/assets/scripts
117|3. Confirm `readiness_status: available`
118|
119|---
120|
121|## Ecosystem-Level Competitive Analysis
122|
123|When the user asks to "compare against competitors" or "对标竞品" across an entire ecosystem (multiple repos + skills), use this workflow **before** the fusion phases above.
124|
125|### Step 1 · Map Your Inventory
126|
127|```bash
128|# List all GitHub repos
129|gh repo list <org> --limit 50
130|
131|# List all local skills
132|skills_list()  # via skill tool
133|```
134|
135|Group into capability domains (e.g., AI生图, 安全检测, 视频创作, 金融量化).
136|
137|### Step 2 · Identify Competitors
138|
139|For each domain, search GitHub trending / web for top competitors. Record: stars, positioning, tech stack, user base.
140|
141|### Step 3 · Build Comparison Tables
142|
143|For each domain, create a 5-column table:
144|
145|| 维度 | 竞品 | 我们 | 差距 | 行动建议 |
146|
147|Key dimensions: Stars, 定位, 技术栈, 用户群, 差异化, 生态.
148|
149|### Step 4 · Prioritize Opportunities
150|
151|Rank by impact × feasibility:
152|- **P0** (1-2周): Immediate competitive advantage, low effort
153|- **P1** (2-4周): High impact, moderate effort
154|- **P2** (1-3月): Strategic, higher effort
155|
156|### Step 5 · Execute Fusion (use Phases 1-6 above)
157|
158|For each P0 opportunity, identify the repos to merge and execute the standard fusion workflow.
159|
160|---
161|
162|## Multi-Repo GitHub Fusion
163|
164|When fusing multiple GitHub repos into a **new unified repo** (not just merging into an existing skill directory):
165|
166|### Step 1 · Clone all source repos
167|
168|```bash
169|cd /tmp && mkdir fusion-workspace && cd fusion-workspace
170|gh repo clone <org>/<repo1>
171|gh repo clone <org>/<repo2>
172|```
173|
174|### Step 2 · Create unified directory structure
175|
176|```bash
177|mkdir unified-suite/{module-a,module-b,module-c,docs}
178|```
179|
180|Map each source repo to its logical module. Don't just dump everything at root level.
181|
182|### Step 3 · Write unified README.md
183|
184|Must include:
185|- **定位** (positioning vs competitors)
186|- **Architecture diagram** (ASCII art showing how modules connect)
187|- **竞品对比表** (comparison table)
188|- **Quick Start** (minimal viable example)
189|- **目录结构** (file tree)
190|- **Roadmap** (what's done, what's next)
191|
192|### Step 4 · Write unified SKILL.md (if it's a Hermes skill)
193|
194|Standard Hermes SKILL.md format with trigger conditions and module pointers.
195|
196|### Step 5 · Push to GitHub
197|
198|```bash
199|cd unified-suite
200|git init && git add . && git commit -m "message"
201|gh repo create <org>/<name> --public --description "..." --source . --push
202|```
203|
204|### Pitfall: Repos may only exist on GitHub
205|
206|Source repos might not be cloned locally. Always check `find /root -maxdepth 4 -name "<repo>" -type d` first; if not found, `gh repo clone` them.
207|
208|### Pitfall: Duplicate files across sources
209|
210|When merging repos that share a common ancestor (e.g., genesisix and genesisix-hermes), files may be near-identical. Use `diff` to check before copying; prefer the newer/more complete version.
211|
212|### Pitfall: .git directories in copy targets
213|
214|Never `cp -r` a repo that includes `.git/` into another repo. Always exclude `.git` dirs: `cp -r source/* target/ && rm -rf target/.git`
215|
216|---
217|
218|## Brand Cleanup After Fusion (MANDATORY)
219|
220|When absorbing external repos into your ecosystem, **every external brand reference is a legal risk**. After file merge, run a mandatory brand sweep before pushing.
221|
222|### Step 1 · Scan All Files
223|
224|```python
225|import os, re
226|
227|patterns = [
228|    (r'OriginalAuthorName', 'author'),
229|    (r'OriginalBrand|original-brand', 'brand'),
230|    (r'OriginalGitHubUser', 'user'),
231|    (r'OtherPlatform|other-platform', 'platform'),
232|]
233|
234|for root, dirs, files in os.walk(target_dir):
235|    dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules']]
236|    for f in files:
237|        if f.endswith(('.pyc', '.png', '.jpg', '.mp3')): continue
238|        content = open(os.path.join(root, f), errors='ignore').read()
239|        for pat, label in patterns:
240|            if re.search(pat, content, re.IGNORECASE):
241|                # Flag for replacement
242|```
243|
244|### Step 2 · Classify Hits
245|
246|| Category | Action | Example |
247||----------|--------|---------|
248|| **Author name** | Replace with your team name | 花叔 → 设计师, 陈宇锋 → 智械工坊 |
249|| **Brand name** | Replace with product name | Huashu Design → Canvas Design |
250|| **Platform name** | Replace with your platform | Claude Code → Hermes Agent |
251|| **GitHub username** | Replace with your org | op7418 → 503496348-ops |
252|| **API endpoint** | KEEP (functional) | api.anthropic.com in config.json |
253|| **External reference links** | KEEP (attribution) | Links to articles about the tool |
254|| **CSS/JS variable** | KEEP (functional) | `cursor: pointer`, `let cursor = 0` |
255|| **LICENSE attribution** | Update, don't delete | Add your team name alongside original |
256|
257|### Step 3 · Verify Zero Residual
258|
259|After replacements, run a final grep scan. **Zero hits** for brand/author patterns is the only acceptable result.
260|
261|### Pitfall: Binary files contain brand strings too
262|PNG/JPG files may embed brand metadata. Don't try to edit binary files — only scan text files. If a PNG has the original brand in its filename, rename it.
263|
264|### Pitfall: localStorage keys and User-Agent strings
265|Internal identifiers like `localStorage.setItem('guizang-ppt-low-power', ...)` are functional. Replace the brand prefix but keep the key working. Add a comment noting the original source and your ownership.
266|
267|## Deep Competitive Integration (NOT just branding)
268|
269|The user will call you out if you only change brand names without actually learning from competitors. Real integration requires:
270|
271|### The 5-Step Discipline
272|
273|1. **Clone and READ the competitor's core source code** — not just README
274|2. **Extract 3-5 specific design patterns** — architecture decisions, algorithms, data structures
275|3. **Write those patterns into YOUR code** — as new modules, not comments
276|4. **Verify with self-tests** — `python3 new_module.py` must produce real output
277|5. **Push with evidence** — commit message includes line counts, test results, what was learned
278|
279|### What "reading core code" means
280|
281|| Competitor Component | What to Extract |
282||---------------------|-----------------|
283|| Architecture pattern | How do modules connect? (pipeline, graph, event-driven) |
284|| Data model | What structures carry state? (TypedDict, dataclass, Pydantic) |
285|| Algorithm | What's the core computation? (scoring, matching, detection) |
286|| API design | How do users invoke it? (CLI flags, function signatures) |
287|| Quality gates | How is output validated? (tests, checklists, scoring) |
288|
289|### Pitfall: Sub-agents timeout on large repos
290|Don't delegate "clone + analyze + improve + push" as one task. Break it into:
291|1. Clone + read (yourself, fast)
292|2. Extract patterns (yourself, analysis)
293|3. Write code (yourself or delegate with specific context)
294|4. Verify + push (yourself)
295|
296|## Honest Reporting Discipline
297|
298|When reporting competitive integration results, the user demands specificity:
299|
300|| ❌ Vague (will get called out) | ✅ Specific (acceptable) |
301||-------------------------------|------------------------|
302|| "做了竞品融合升级" | "+analyzer_pipeline.py (291行), 3个分析器, 自测通过" |
303|| "大部分仓已修复" | "12/13仓已推, 4个只有品牌清洗, 3个有代码改动, 6个已干净无需改动" |
304|| "对标了SkillSpector" | "读了SkillSpector的graph.py和prompt_injection.py, 提取了模块化分析器+置信度评分模式, 写入analyzer_pipeline.py" |
305|| "子Agent做了改动" | "子Agent超时前写了1386行代码, 但我没验证质量, 不确定是否有用" |
306|
307|**Rule**: Every push must include in the commit message: (1) exact file count, (2) line count, (3) what was learned from the competitor, (4) self-test result.
308|
309|## Bitable-Driven Batch Product Fusion
310|
311|When the user provides a Bitable product table with GitHub repos and competitor columns, use this workflow (from competitive-product-fusion):
312|
313|### Prerequisites
314|🔴 **产品仓库 ≠ 本地技能列表。** 从用户的 Bitable 产品表读取真实记录，不要把 `skills_list` 当产品数。
315|
316|### 5-Step Loop
317|1. **拉取竞品**: `gh repo clone <competitor> -- --depth 1`
318|2. **读核心代码**（不是README）: 架构入口、核心数据模型、关键算法、配置/插件注册
319|3. **提炼设计模式**: 从竞品代码提炼可移植模式（模块化管线、声明式策略、插件注册表等）
320|4. **写入+自测+推仓**: 独立可运行、零外部依赖、含docstring、推仓前验证
321|5. **更新Bitable**: 记录对标谁、新增模块、代码行数
322|
323|### 产出标准
324|- 每个产品仓库：1个核心模块（100-350行Python）
325|- 自测通过（`python3`直接运行）
326|- docstring注明对标来源
327|
328|### 踩坑
329|- 子Agent超时：clone+分析+改造+推仓链路太长，主Agent自己做更可靠
330|- `gh repo clone --depth 1` 需要双横杠：`gh repo clone <repo> -- --depth 1`
331|- Bitable `+record-upsert` 的 `--json` 需要顶层字段map，不是 `{\"fields\": {...}}`
332|
333|---
334|
335|## Pitfalls
336|
337|### Disk space
338|Large skill fusions (40MB+) can fill up `/tmp` or the root filesystem. Before copying, check `df -h /` and clean up pip caches, node_modules, and old temp files if space is tight.
339|
340|### Shared-write idempotency blocking
341|When rewriting a skill's SKILL.md that was previously written in the same session, the shared-write system may block the write. Workaround: write to `/tmp/` first, then `HERMES_ALLOW_SHARED_WRITE_DUPLICATE=1 cp` to the target.
342|
343|### File name collisions
344|Two sources may have files with the same name but different content (e.g., both have `references/workflow.md`). Resolve by:
345|- Renaming the absorbed version (e.g., `workflow-source-a.md`)
346|- Or keeping the target's version and noting the conflict
347|
348|### Over-engineering the SKILL.md
349|Don't dump everything into SKILL.md. The fused file should be a **navigation hub** that points to references/ for deep detail. If SKILL.md exceeds 500 lines, extract sections into reference files.
350|
351|### Losing the target's identity
352|The biggest risk: the fused SKILL.md reads like a mashup of three skills rather than one coherent skill with new capabilities. Always start with the target's philosophy and identity, then layer in absorbed capabilities as new "modes" or "paths" within that identity.
353|
354|---
355|
356|## Example: canvas-design fusion (2026-06-18)
357|
358|**Sources**: canvas-design (static art) + huashu-design (HTML design engine) + frontend-slides (presentation) + guizang-ppt-skill (Swiss layouts)
359|
360|**Fusion strategy**: canvas-design identity (design philosophy-driven) + huashu-design workflow as backbone + frontend-slides style discovery + guizang Swiss layouts
361|
362|**Result**:
363|- References: 4 → 41 files
364|- Scripts: 0 → 19
365|- Templates: 0 → 2 HTML templates + 34 bold templates
366|- Capability: static art only → art + deck + prototype + motion + narration video
367|- Size: ~5MB → 42MB
368|
369|**Key learning**: The capability overview table (showing what came from where) is essential for traceability and future maintenance.
370|
371|---
372|
373|## Example: hermes-security-suite fusion (2026-06-19)
374|
375|**Sources**: genesisix (core detection) + genesisix-hermes (Hermes integration) + hermes-doctor (self-diagnosis)
376|
377|**Fusion strategy**: Create new unified repo with 3 logical modules (detector/doctor/hooks) under one README.
378|
379|**Workflow**:
380|1. Cloned both GitHub repos to `/tmp/security-merge/`
381|2. Created unified directory structure with 3 modules
382|3. Wrote unified README with: positioning vs competitors, ASCII architecture diagram, 8-column comparison table
383|4. Wrote unified SKILL.md with trigger conditions
384|5. Created hooks/policy.yaml (new capability not in any source)
385|6. `gh repo create --source . --push`
386|
387|**Result**:
388|- Files: 80 (genesisix) + 40 (genesisix-hermes) + 30 (hermes-doctor) → 184 unified
389|- New: hooks/ module (real-time interception, not in any source)
390|- GitHub: https://github.com/503496348-ops/hermes-security-suite
391|
392|**Key learning**: When merging repos with shared ancestry (genesisix ≈ genesisix-hermes), diff files first to avoid near-duplicates. The unified README's 竞品对比表 is the single most important document — it defines positioning.
393|
394|---
395|
396|## External Skill Adaptation (Import from Other AI Platforms)
397|
398|When the user provides a plan or request to convert skills from **other AI coding platforms** (Claude Code superpowers, Cursor rules, Windsurf skills, GitHub Copilot instructions, etc.) into Hermes-compatible skills, use this workflow. This is distinct from fusion — you're creating NEW skills, not merging into existing ones.
399|
400|### Phase 0 · Audit the Plan for Hallucinations
401|
402|**CRITICAL**: External plans often contain fabricated commands and wrong assumptions. Before executing ANYTHING, verify:
403|
404|| What to check | How | Common hallucination |
405||---------------|-----|---------------------|
406|| Installation commands | Try them in a dry-run | `npx skills add <repo>` doesn't exist for most repos |
407|| CLI lock/version commands | Check if the CLI actually has them | `superpowers skills lock --save` — fabricated |
408|| Trigger mechanisms | Check if the target platform supports them | File-suffix triggers (.tsx/.vue) are Cursor/Windsurf, not Hermes |
409|| Repo existence | `gh repo view <org>/<name>` or web_search | Repos may not exist, may have been renamed, or donated elsewhere |
410|| Skill format assumptions | Read the repo's actual SKILL.md/CLAUDE.md | YAML fields like `disable-model-invocation`, `user-invocable` may not exist |
411|
412|**Red flags in plans**: `npx skills add`, `skills lock`, file-watching triggers, "auto-load based on file type", repos that are CLI tools (not skill collections).
413|
414|### Phase 1 · Select and Prioritize
415|
416|Not every skill in an external repo is worth converting. Selection criteria:
417|
418|1. **No overlap with existing Hermes skills** — check `skills_list()` first
419|2. **High signal-to-noise ratio** — prefer skills with clear, actionable content over meta-skills
420|3. **Priority hierarchy** when multiple skills address the same domain:
421|   - **Level 1 (highest)**: Core workflow skills (dev process, TDD, code review)
422|   - **Level 2**: Engineering norms (architecture, security, performance)
423|   - **Level 3 (lowest)**: Domain-specific details (frontend, backend, tooling)
424|
425|### Phase 2 · Convert to Hermes Format
426|
427|The conversion recipe for each skill:
428|
429|```
430|1. Read source SKILL.md (or equivalent)
431|2. Strip frontmatter (platform-specific YAML)
432|3. Build Hermes frontmatter:
433|   - name: kebab-case, must be unique across all skills
434|   - description: 1-2 sentences, include source attribution
435|   - triggers: 8-12 keywords (Chinese + English mix)
436|   - tags: categorization tags
437|   - version: from source if available, else 1.0.0
438|4. Replace platform references:
439|   - "Claude Code" → "Hermes"
440|   - "invoke the Skill tool" → "use skill_view()"
441|   - "superpowers:" → "naughty-studio/"  (namespace mapping)
442|5. Copy reference files (references/, templates/, scripts/)
443|6. Write to ~/.hermes/skills/<category>/<name>/SKILL.md
444|```
445|
446|### Phase 3 · Verify
447|
448|After converting all skills:
449|
450|1. **Frontmatter integrity**: Every SKILL.md must have `---` delimiters, `name`, `description`
451|2. **Naming conflicts**: `ls <target_dir>/ | sort | uniq -d` must return empty
452|3. **Trigger overlap**: `grep -rh '  - "' */SKILL.md | sort | uniq -d` — minor overlaps are acceptable (Hermes lists all matching skills), but flag them
453|4. **Loadability**: Spot-check 2-3 skills with `skill_view(name=<name>)`
454|5. **Reference files**: Verify all referenced files exist in the skill directory
455|
456|### Pitfalls
457|
458|#### read_file dedup caching in execute_code
459|When reading the same file twice in one `execute_code` block, the second call returns `{'status': 'unchanged', 'content_returned': False}` which causes `KeyError: 'content'`. **Workaround**: Use `terminal("cat ...")` for subsequent reads of the same file.
460|
461|#### Plan contains non-existent repos
462|Some repos in plans are CLI tools (not skill collections), have been renamed, or donated to foundations. Always verify with `gh repo view` or web_search before cloning.
463|
464|#### Trigger keyword conflicts across new skills
465|When converting 10+ skills at once, some trigger keywords will inevitably overlap (e.g., "接口设计" in both api-and-interface-design and codebase-design). This is acceptable — Hermes presents all matching skills and the user chooses. Don't over-optimize trigger uniqueness.
466|
467|#### MEMORY.md drift from external edits
468|If `memory(action='add')` fails with "file on disk has content that wouldn't round-trip", read the .bak file, then `write_file` the entire MEMORY.md with the new entry appended. The § delimiter format must be preserved.
469|
470|### Step 4 · Platform Adaptation (MANDATORY for non-Hermes sources)
471|
472|When importing skills from Claude Code, Cursor, Windsurf, or other AI platforms, **all platform-specific references must be replaced** before the skills are usable. See `references/claude-code-to-hermes-translation.md` for the full replacement map and automated script.
473|
474|Key replacements: `Claude Code` → `Hermes Agent`, `CLAUDE.md` → `AGENTS.md`, `.claude/` → `.hermes/`, slash commands (`/dispatch`, `/skill`, `/sdd`) → Hermes tool equivalents.
475|
476|**Important distinction**: This is NOT 竞品融合. External reference skills keep original authorship (Superpowers, Agent-Skills, Mattpocock brand names stay). Only platform dependencies are replaced.
477|
478|### Step 5 · Priority Markers (for overlapping internal/external skills)
479|
480|When imported skills overlap with existing internal Hermes skills, mark priority explicitly. See `references/internal-external-priority-markers.md` for the workflow.
481|
482|Rule: Internal Hermes skill = primary (append "本skill为Hermes原生主技能" to description). External skill = supplementary (add YAML comment noting what it supplements).
483|
484|### Bulk Import Variant
485|
486|When importing **entire repos as-is** (symlinks, not merging into one target), see `references/bulk-repo-import-workflow.md` for the full workflow: clone + prefix symlinks, bulk triggers injection, cross-repo conflict audit with priority-based resolution, and a real 5-repo / 60-skill example.
487|
488|## 品牌信息

- **中文名**: 顽皮制造
- **英文名**: Mischief Production
- **原名**: skill-fusion
- **改名日期**: 2026-06-30

## Support Files
489|
490|- `references/competitive-analysis-template.md` — Structured template for ecosystem-level competitive analysis reports (7 sections: comparison tables, priority matrix, fusion plan, positioning, risks, KPIs).
491|- `references/external-skill-adaptation-recipe.md` — Step-by-step conversion recipe with code templates for adapting external AI platform skills into Hermes format.
492|- `references/bulk-repo-import-workflow.md` — Symlink + triggers injection + cross-repo conflict audit for importing entire external skill repos into Hermes (5-repo real-world example included).
493|- `references/claude-code-to-hermes-translation.md` — Full replacement map (Claude Code → Hermes) with automated script and verification. Covers product names, config files, directory paths, slash commands.
494|- `references/internal-external-priority-markers.md` — How to mark priority when external imported skills overlap with existing internal Hermes skills. YAML comment injection pattern.
495|