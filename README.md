# 全栈开发工具包 · Full Stack DevKit

**全栈开发工具包** — 把外部高星仓库的能力融合进智械工坊产品。

## 一键安装

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/503496348-ops/mischief-production/master/install.sh)
```

或手动：

```bash
git clone https://github.com/503496348-ops/mischief-production.git /tmp/mp && bash /tmp/mp/install.sh
```

## 包含什么

| 前缀 | 来源仓库 | ⭐ | 融合能力 | 数量 |
|------|----------|-----|---------|------|
| `sp-*` | [obra/superpowers](https://github.com/obra/superpowers) | 218K | 7步开发流水线、TDD、代码评审、子Agent调度、架构设计 | 14 |
| `as-*` | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | — | 分布式架构、系统设计、前后端性能、安全扫描、CI/CD | 24 |
| `mp-*` | [mattpocock/skills](https://github.com/mattpocock/skills) | — | TypeScript编码规范、类型约束、代码重构 | 6 |
| `ecc-*` | [anthropics/claude-code-skillset](https://github.com/anthropics/claude-code-skillset) | — | 全栈专项：Django/FastAPI/Spring/React/Vue/Flutter/Rust/Go/DevOps/MLOps/区块链/医疗/物流等 | 277 |
| `awc-*` | 自研 | — | 网站逆向克隆模板 | 1 |

**合计：322 个技能**

## 安装后

- 技能自动被 Hermes Agent 发现，无需重启
- Hermes 根据任务描述自动匹配加载对应 skill
- 按需加载，不会一次性把 322 个 skill 全塞进上下文

## 卸载

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/503496348-ops/mischief-production/master/uninstall.sh)
```

## 目录结构

```
skills/          ← 322 个 skill 目录，每个含 SKILL.md
install.sh       ← 安装脚本（复制 skills/ → ~/.hermes/skills/）
uninstall.sh     ← 卸载脚本（按前缀精准删除）
README.md
```

## 技能来源

所有技能来自 GitHub 公开仓库，已移除上游引用信息，统一适配 Hermes Agent 格式。
