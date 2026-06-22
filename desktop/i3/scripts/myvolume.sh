#!/usr/bin/env bash
set -euo pipefail

amixer -D pulse get Master |
  sed -n -E 's/^.*(\[[0-9]+%\]).*$/\1/p' |
  head -n 1
