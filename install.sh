#!/usr/bin/env bash
# Queendom Skills Pack — 一键部署脚本
# 用法: bash install.sh [--force]
#   --force  覆盖已存在的同名 skill（默认跳过）

set -euo pipefail

HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
TARGET="$HERMES_HOME/skills"
FORCE=false

[[ "${1:-}" == "--force" ]] && FORCE=true

# 预检
if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "❌ 找不到 skills/ 目录，请在仓库根目录执行此脚本"
  exit 1
fi

mkdir -p "$TARGET"

installed=0
skipped=0
total=0

for skill_dir in "$SKILLS_SRC"/*/; do
  [[ -d "$skill_dir" ]] || continue
  name=$(basename "$skill_dir")
  total=$((total + 1))
  link="$TARGET/$name"

  if [[ -e "$link" || -L "$link" ]]; then
    if $FORCE; then
      rm -rf "$link"
    else
      skipped=$((skipped + 1))
      continue
    fi
  fi

  # 复制实际文件（不是 symlink，避免源目录被删后失效）
  cp -r "$skill_dir" "$link"
  installed=$((installed + 1))
done

echo ""
echo "✅ Queendom Skills Pack 部署完成"
echo "   已安装: $installed / $total"
[[ $skipped -gt 0 ]] && echo "   跳过（已存在）: $skipped（用 --force 覆盖）"
echo "   路径: $TARGET"
echo ""
echo "Hermes 会自动发现这些 skill，无需重启。"
