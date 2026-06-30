# 🏰 Queendom Skills Pack

**54 个 Hermes Agent 技能，一键部署。**

> 这些技能来自全球顶级开源仓库（obra/superpowers、addyosmani/agent-skills、mattpocock/skills、affaan-m/ECC、ai-website-cloner-template），经过 Hermes 格式适配，可直接被 Hermes Agent 自动发现和加载。

## 🚀 一键安装

```bash
# 方式一：克隆 + 安装
git clone https://github.com/503496348-ops/mischief-production.git /tmp/mischief-production
bash /tmp/mischief-production/install.sh

# 方式二：一行搞定
git clone https://github.com/503496348-ops/mischief-production.git /tmp/mischief-production && bash /tmp/mischief-production/install.sh
```

安装完成后 Hermes 自动发现，**无需重启**。

## 📦 包含什么

### 🏗️ 基座层 — sp-*（14个，obra/superpowers ⭐218k）

标准化软件工程全流程，覆盖从需求到交付的每一步。

| 技能 | 用途 |
|------|------|
| sp-brainstorming | 创意探索，实现前先搞清楚要做什么 |
| sp-writing-plans | 多步骤任务的实现计划编写 |
| sp-executing-plans | 按计划执行，带 review checkpoint |
| sp-test-driven-development | TDD：先写测试，再写实现 |
| sp-systematic-debugging | 遇到 bug 先诊断，别急着修 |
| sp-subagent-driven-development | 子 Agent 并行开发独立任务 |
| sp-dispatching-parallel-agents | 多任务并行调度 |
| sp-requesting-code-review | 完成后主动请求代码评审 |
| sp-receiving-code-review | 收到 review 反馈后的正确处理方式 |
| sp-verification-before-completion | 完成前必须验证，证据优先于声明 |
| sp-finishing-a-development-branch | 分支完成后的 merge/PR 决策 |
| sp-using-git-worktrees | Git worktree 隔离开发 |
| sp-using-superpowers | 技能发现的元技能 |
| sp-writing-skills | 编写和编辑 skill 的规范 |

### 🔧 增强层 — as-*（19个，addyosmani/agent-skills）

谷歌 Chrome 团队工程规范，补强架构、安全、性能、CI/CD。

| 技能 | 用途 |
|------|------|
| as-api-and-interface-design | API 和接口设计规范 |
| as-browser-testing-with-devtools | Chrome DevTools 浏览器测试 |
| as-ci-cd-and-automation | CI/CD 流水线搭建 |
| as-code-simplification | 代码简化重构 |
| as-context-engineering | Agent 上下文优化 |
| as-deprecation-and-migration | 废弃和迁移管理 |
| as-documentation-and-adrs | 文档和架构决策记录 |
| as-doubt-driven-development | 质疑驱动开发：高风险决策前先对抗审查 |
| as-frontend-ui-engineering | 生产级前端 UI 构建 |
| as-idea-refine | 想法精炼：发散→收敛 |
| as-incremental-implementation | 增量交付：大改动拆小步 |
| as-interview-me | 用户意图深度挖掘 |
| as-observability-and-instrumentation | 可观测性：日志、指标、追踪 |
| as-performance-optimization | 性能优化 |
| as-security-and-hardening | 安全加固 |
| as-shipping-and-launch | 生产发布准备 |
| as-source-driven-development | 基于官方文档的实现 |
| as-spec-driven-development | 先写 spec 再写代码 |
| as-using-agent-skills | 技能发现和调用的元技能 |

### 📐 规范层 — mp-*（12个，mattpocock/skills）

TypeScript 领域顶级编码规范，统一前后端代码风格。

| 技能 | 用途 |
|------|------|
| mp-codebase-design | 深度模块设计 |
| mp-domain-modeling | 领域建模和统一语言 |
| mp-grilling | 方案压力测试 |
| mp-grill-with-docs | 压力测试 + 自动产出 ADR |
| mp-handoff | 会话交接文档生成 |
| mp-improve-codebase-architecture | 架构改进建议报告 |
| mp-prototype | 一次性原型验证 |
| mp-resolving-merge-conflicts | Git merge 冲突解决 |
| mp-teach | 教学新技能或概念 |
| mp-to-prd | 对话转 PRD |
| mp-triage | Issue/PR 分诊 |
| mp-writing-great-skills | 编写优质 skill 的参考 |

### 🛡️ 专项层 — ecc-*（8个，affaan-m/ECC ⭐）

全栈工程最佳实践，覆盖后端、数据库、Docker、Python。

| 技能 | 用途 |
|------|------|
| ecc-backend-patterns | 后端架构模式 |
| ecc-database-migrations | 数据库迁移最佳实践 |
| ecc-docker-patterns | Docker 模式 |
| ecc-error-handling | 跨语言错误处理 |
| ecc-fastapi-patterns | FastAPI 最佳实践 |
| ecc-github-ops | GitHub 运维操作 |
| ecc-mcp-server-patterns | MCP Server 构建 |
| ecc-python-patterns | Python 编码规范 |

### 🕸️ 克隆层 — awc-*（1个）

| 技能 | 用途 |
|------|------|
| awc-clone-website | 网站逆向克隆：提取资产、CSS、内容，逐段重建 |

## 🧹 卸载

```bash
bash /tmp/mischief-production/uninstall.sh
```

只删除 symlink，不影响源文件。

## ⚡ 工作原理

Hermes Agent 每次对话时自动扫描 `~/.hermes/skills/` 下所有已注册 skill 的名称和描述，根据用户意图**按需加载**。54 个 skill 不会同时占用上下文，只在匹配时才激活。

安装脚本通过 symlink 将仓库中的 skill 链接到 `~/.hermes/skills/`，Hermes 自动发现。

## 📝 更新

```bash
cd /tmp/mischief-production && git pull
```

## 📄 License

各 skill 遵循原仓库许可证：
- sp-*: MIT (obra/superpowers)
- as-*: MIT (addyosmani/agent-skills)
- mp-*: MIT (mattpocock/skills)
- ecc-*: MIT (affaan-m/ECC)
- awc-*: MIT (ai-website-cloner-template)
