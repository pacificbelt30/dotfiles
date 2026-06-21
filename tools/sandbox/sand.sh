#!/usr/bin/env bash
# sand: build (if needed) and enter a disposable Docker sandbox based on this
# dotfiles repo (see ./Dockerfile), with the current directory mounted at
# /work inside the container.
#
# Usage:
#   sand                # drop into an interactive zsh shell
#   sand gdb ./chal      # run a one-off command inside the sandbox instead
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
IMAGE_NAME="dotfiles-sandbox"

docker build -q -t "$IMAGE_NAME" -f "$DOTFILES_DIR/tools/sandbox/Dockerfile" "$DOTFILES_DIR" >/dev/null

exec docker run --rm -it \
  -v "$(pwd):/work" \
  -w /work \
  "$IMAGE_NAME" "$@"
