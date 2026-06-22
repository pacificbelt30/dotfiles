#!/usr/bin/env bash
# Create a uv-managed virtualenv for pwn/CTF work (pwntools, ptrlib, etc.)
# based on the pyproject.toml in this directory.
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v uv >/dev/null 2>&1; then
  echo "uv not found. Run ../install_uv.sh first." >&2
  exit 1
fi

PYTHON_VERSION="${PYTHON_VERSION:-3.12}"
uv python install "$PYTHON_VERSION"
uv sync --python "$PYTHON_VERSION"

echo "Done. Activate with: source $(pwd)/.venv/bin/activate"
echo "Or run a one-off command with: uv run --project $(pwd) python exploit.py"
