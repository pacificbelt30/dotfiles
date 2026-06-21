#!/usr/bin/env bash
# Install pwndbg (https://github.com/pwndbg/pwndbg), a GDB plugin for
# exploit development and reverse engineering. Its setup.sh registers
# itself in ~/.gdbinit so it loads automatically the next time gdb starts.
set -euo pipefail

PWNDBG_DIR="${PWNDBG_DIR:-$HOME/.local/share/pwndbg}"

if [ -d "$PWNDBG_DIR/.git" ]; then
  echo "Updating existing pwndbg in $PWNDBG_DIR"
  git -C "$PWNDBG_DIR" pull --ff-only
else
  echo "Cloning pwndbg into $PWNDBG_DIR"
  git clone https://github.com/pwndbg/pwndbg "$PWNDBG_DIR"
fi

if ! command -v gdb >/dev/null 2>&1; then
  echo "warning: gdb not found on PATH. Install it first (see tools/cli/install_cli_tools.sh)." >&2
fi

cd "$PWNDBG_DIR"
./setup.sh

echo "Done. pwndbg will load automatically the next time you start gdb."
