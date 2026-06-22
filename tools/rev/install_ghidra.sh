#!/usr/bin/env bash
# Install the latest Ghidra release (https://github.com/NationalSecurityAgency/ghidra)
# into ~/.local/share/ghidra and expose `ghidra` on PATH via ~/.local/bin.
# Requires a JDK (21+) to actually run Ghidra; this script does not install one.
set -euo pipefail

GHIDRA_INSTALL_DIR="${GHIDRA_INSTALL_DIR:-$HOME/.local/share/ghidra}"
BIN_DIR="$HOME/.local/bin"

if [ -x "$GHIDRA_INSTALL_DIR/ghidraRun" ]; then
  echo "Ghidra is already installed in $GHIDRA_INSTALL_DIR"
else
  echo "Resolving latest Ghidra release..."
  API_URL="https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest"
  ASSET_URL=$(curl -fsSL "$API_URL" | grep -oE '"browser_download_url": *"[^"]+_PUBLIC_[^"]+\.zip"' | grep -oE 'https://[^"]+' | head -n1)

  if [ -z "$ASSET_URL" ]; then
    echo "Could not resolve a Ghidra download URL from $API_URL" >&2
    exit 1
  fi

  WORK_DIR="$(mktemp -d)"
  trap 'rm -rf "$WORK_DIR"' EXIT

  echo "Downloading $ASSET_URL"
  curl -fL "$ASSET_URL" -o "$WORK_DIR/ghidra.zip"

  echo "Extracting..."
  unzip -q "$WORK_DIR/ghidra.zip" -d "$WORK_DIR/extracted"
  EXTRACTED_DIR=$(find "$WORK_DIR/extracted" -maxdepth 1 -type d -name 'ghidra_*')

  mkdir -p "$(dirname "$GHIDRA_INSTALL_DIR")"
  rm -rf "$GHIDRA_INSTALL_DIR"
  mv "$EXTRACTED_DIR" "$GHIDRA_INSTALL_DIR"
fi

mkdir -p "$BIN_DIR"
ln -snf "$GHIDRA_INSTALL_DIR/ghidraRun" "$BIN_DIR/ghidra"

if ! command -v java >/dev/null 2>&1; then
  echo "warning: no 'java' on PATH. Ghidra needs a JDK 21+ to run (e.g. 'sudo pacman -S jdk-openjdk' / 'sudo apt-get install openjdk-21-jdk')." >&2
fi

echo "Done. Installed to $GHIDRA_INSTALL_DIR, launch with: ghidra"
