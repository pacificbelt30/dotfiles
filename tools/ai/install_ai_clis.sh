#!/usr/bin/env bash
# Install AI coding CLIs (Claude Code, OpenAI Codex CLI) via npm.
# Requires Node.js/npm (see lang/node/install_nvm.sh) to be on PATH.
set -euo pipefail

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if ! command -v npm >/dev/null 2>&1 && [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found. Run lang/node/install_nvm.sh first." >&2
  exit 1
fi

echo "Installing @anthropic-ai/claude-code..."
npm install -g @anthropic-ai/claude-code

echo "Installing @openai/codex..."
npm install -g @openai/codex

echo "Done."
command -v claude >/dev/null 2>&1 && echo "claude: $(claude --version 2>/dev/null || echo installed)"
command -v codex >/dev/null 2>&1 && echo "codex: $(codex --version 2>/dev/null || echo installed)"
