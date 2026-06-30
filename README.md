# 🏰 Queendom Skills Pack

**322 个 Hermes Agent 技能，一键部署。**

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

| 分类 | 前缀 | 数量 | 来源 | 说明 |
|------|------|------|------|------|
| **全局基座** | sp-* | 14 | obra/superpowers ⭐218k | 标准化软件工程全流程：需求→架构→TDD→评审→交付 |
| **工程增强** | as-* | 24 | addyosmani/agent-skills | 谷歌 Chrome 团队工程规范：API设计、安全、性能、CI/CD |
| **编码规范** | mp-* | 6 | mattpocock/skills | TS 领域顶级编码规范：领域建模、代码评审、PRD |
| **全栈专项** | ecc-* | 277 | affaan-m/ECC ⭐ | 全栈最佳实践：后端、前端、数据库、Docker、安全、测试 |
| **网站克隆** | awc-* | 1 | ai-website-cloner-template | 网站逆向克隆：提取资产、CSS、逐段重建 |

**总计：322 个 skill**

### 🏗️ 基座层 — sp-*（14个）

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

### 🔧 增强层 — as-*（24个）

谷歌 Chrome 团队工程规范，补强架构、安全、性能、CI/CD。

涵盖：API设计、浏览器测试、CI/CD、代码简化、上下文工程、废弃迁移、文档ADR、质疑驱动开发、前端UI、想法精炼、增量交付、意图挖掘、可观测性、性能优化、安全加固、生产发布、源码驱动、规格驱动等。

### 📐 规范层 — mp-*（6个）

TypeScript 领域顶级编码规范，按工程/生产力/杂项/个人/进行中/废弃分类。

### 🛡️ 全栈专项 — ecc-*（277个）

覆盖 20+ 技术栈的完整最佳实践：

**语言/框架**: Python、TypeScript、Go、Rust、Java、Kotlin、Swift、C++、C#、F#、Perl、Dart/Flutter、Vue、React、Next.js、Nuxt、Angular、NestJS、Django、Laravel、Spring Boot、FastAPI、Quarkus、Prisma、Express

**基础设施**: Docker、Kubernetes、PostgreSQL、MySQL、Redis、ClickHouse、GraphQL

**工程实践**: TDD、代码评审、安全加固、性能优化、API设计、数据库迁移、CI/CD、可观测性、部署模式

**AI/ML**: PyTorch、DSPy、vLLM、RLHF/DPO/GRPO、GGUF量化、LoRA微调

**安全**: OWASP、HIPAA、供应链安全、密钥管理

### 🕸️ 网站克隆 — awc-*（1个）

| 技能 | 用途 |
|------|------|
| awc-clone-website | 网站逆向克隆：提取资产、CSS、内容，逐段重建 |

## 🧹 卸载

```bash
bash /tmp/mischief-production/uninstall.sh
```

## ⚡ 工作原理

Hermes Agent 每次对话时自动扫描 `~/.hermes/skills/` 下所有已注册 skill 的名称和描述，根据用户意图**按需加载**。322 个 skill 不会同时占用上下文，只在匹配时才激活。

安装脚本将仓库中的 skill 复制到 `~/.hermes/skills/`，Hermes 自动发现。

## 📝 更新

```bash
cd /tmp/mischief-production && git pull && bash install.sh --force
```

## 📄 License

各 skill 遵循原仓库许可证。
