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

# Build the "sandbox" user with the same UID as the host user (Dockerfile
# handles UID 1000 already being taken by ubuntu:24.04's pre-created user),
# so files written under the /work mount keep sane ownership on the host.
# Tag the image per-UID so switching hosts/users doesn't reuse a mismatched image.
HOST_UID="$(id -u)"
IMAGE_NAME="dotfiles-sandbox-${HOST_UID}"

docker build -q -t "$IMAGE_NAME" \
  --build-arg "UID=${HOST_UID}" \
  -f "$DOTFILES_DIR/tools/sandbox/Dockerfile" "$DOTFILES_DIR" >/dev/null

exec docker run --rm -it \
  -v "$(pwd):/work" \
  -w /work \
  "$IMAGE_NAME" "$@"
