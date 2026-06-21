#!/usr/bin/env bash
# Install general-purpose CLI tools and small binary-analysis utilities:
# ripgrep, eza, fd, bat, hexyl, binwalk, binutils (objdump/readelf/nm/strings),
# gdb, and checksec.
set -uo pipefail

PACMAN_PKGS=(ripgrep eza fd bat hexyl binwalk binutils gdb)
APT_PKGS=(ripgrep eza fd-find bat hexyl binwalk binutils gdb)

install_with_pacman() {
  echo "Installing via pacman: ${PACMAN_PKGS[*]}"
  for pkg in "${PACMAN_PKGS[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg" || echo "warning: failed to install '$pkg' via pacman" >&2
  done
}

install_with_apt() {
  sudo apt-get update
  echo "Installing via apt: ${APT_PKGS[*]}"
  for pkg in "${APT_PKGS[@]}"; do
    sudo apt-get install -y "$pkg" || echo "warning: failed to install '$pkg' via apt (eza may need https://github.com/eza-community/eza/blob/main/INSTALL.md on older releases)" >&2
  done
}

if command -v pacman >/dev/null 2>&1; then
  install_with_pacman
elif command -v apt-get >/dev/null 2>&1; then
  install_with_apt
else
  echo "Unsupported package manager. Install manually: ${PACMAN_PKGS[*]}" >&2
fi

mkdir -p "$HOME/.local/bin"

# Debian/Ubuntu install fd/bat under fdfind/batcat to avoid clashes; expose
# the canonical names so configs/aliases written for fd/bat keep working.
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -snf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
  ln -snf "$(command -v batcat)" "$HOME/.local/bin/bat"
fi

# checksec: install as a standalone script so it works the same on every distro.
CHECKSEC_PATH="$HOME/.local/bin/checksec"
if [ ! -x "$CHECKSEC_PATH" ]; then
  echo "Installing checksec.sh..."
  curl -fsSL https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec -o "$CHECKSEC_PATH"
  chmod +x "$CHECKSEC_PATH"
fi

echo "Done. rg, eza, fd, bat, hexyl, binwalk, objdump/readelf/nm/strings (binutils), gdb, checksec should now be available."
