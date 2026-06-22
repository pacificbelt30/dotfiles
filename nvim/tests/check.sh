#!/usr/bin/env bash
# Neovim Lua 設定の静的チェック。
#   1. 構文チェック (luac -p) … 全 .lua ファイルがパースできるか
#   2. 静的解析 (luacheck)    … 未定義変数・タイポ等 (.luacheckrc 準拠)
# nvim 本体やプラグインは不要。CI からもローカルからも実行できる。
set -euo pipefail

# リポジトリルートへ移動 (このスクリプトは nvim/tests/ にある想定)
cd "$(dirname "$0")/../.."
ROOT="$(pwd)"
TARGET="nvim"

# .lua ファイル一覧
mapfile -t LUA_FILES < <(find "$TARGET" -name '*.lua' -not -path '*/.git/*' | sort)
if [ "${#LUA_FILES[@]}" -eq 0 ]; then
  echo "対象の .lua ファイルが見つかりません ($TARGET)" >&2
  exit 1
fi

# luac の実体を探す (5.1〜5.4 / 素の luac いずれでも可)
LUAC="$(command -v luac5.4 || command -v luac5.3 || command -v luac5.1 || command -v luac || true)"

fail=0

echo "== 1. 構文チェック (${LUAC:-luac 見つからず}) =="
if [ -n "$LUAC" ]; then
  for f in "${LUA_FILES[@]}"; do
    if ! "$LUAC" -p "$f"; then
      echo "  NG: $f"
      fail=1
    fi
  done
  [ "$fail" -eq 0 ] && echo "  OK: ${#LUA_FILES[@]} ファイル"
else
  echo "  luac が無いためスキップ (lua5.x をインストールすると有効)" >&2
fi

echo "== 2. 静的解析 (luacheck) =="
if command -v luacheck >/dev/null 2>&1; then
  if ! luacheck "$TARGET"; then
    fail=1
  fi
else
  echo "  luacheck が無いためスキップ (luarocks install luacheck)" >&2
fi

if [ "$fail" -ne 0 ]; then
  echo "チェック失敗" >&2
  exit 1
fi
echo "全チェック通過"
