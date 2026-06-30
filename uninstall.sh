#!/usr/bin/env bash
# 卸载 Queendom Skills Pack
# 用法: bash uninstall.sh [--purge]
#   --purge  同时删除源仓库目录（默认只删安装的 skill）

set -euo pipefail

HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
TARGET="$HERMES_HOME/skills"

removed=0
for skill_dir in "$SKILLS_SRC"/*/; do
  [[ -d "$skill_dir" ]] || continue
  name=$(basename "$skill_dir")
  target="$TARGET/$name"
  if [[ -e "$target" || -L "$target" ]]; then
    rm -rf "$target"
    removed=$((removed + 1))
  fi
done

echo "✅ 已移除 $removed 个 skill"
echo "   路径: $TARGET"

if [[ "${1:-}" == "--purge" ]]; then
  echo "   正在删除源目录: $SCRIPT_DIR"
  rm -rf "$SCRIPT_DIR"
  echo "✅ 源目录已删除"
fi
