#!/usr/bin/env bash
# Install uv (https://docs.astral.sh/uv/) and a managed Python toolchain.
# uv replaces system pip/venv/pyenv for this dotfiles setup.
set -euo pipefail

if command -v uv >/dev/null 2>&1; then
  echo "uv is already installed: $(uv --version)"
else
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

echo "Installing latest stable Python via uv..."
uv python install

echo "Done. uv: $(uv --version)"
