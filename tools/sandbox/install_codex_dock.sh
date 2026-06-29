#!/usr/bin/env bash
# Install codex-dock (pacificbelt30/sandbox-codex): AI sandbox container manager.
# Installs Go (if needed), clones the repo, builds, and installs the binary
# and default config.  Requires Docker to be installed first.
set -euo pipefail

REQUIRED_GO_MAJOR=1
REQUIRED_GO_MINOR=24
REPO_URL="https://github.com/pacificbelt30/sandbox-codex.git"
CLONE_DIR="${HOME}/.local/share/codex-dock/src"

# ---- helpers ----------------------------------------------------------------
go_version_ok() {
  command -v go >/dev/null 2>&1 || return 1
  local ver
  ver="$(go version | grep -oP 'go\K[0-9]+\.[0-9]+')"
  local major minor
  major="${ver%%.*}"
  minor="${ver#*.}"
  [[ "$major" -gt "$REQUIRED_GO_MAJOR" ]] && return 0
  [[ "$major" -eq "$REQUIRED_GO_MAJOR" && "$minor" -ge "$REQUIRED_GO_MINOR" ]] && return 0
  return 1
}

install_go() {
  echo "==> Installing Go >= ${REQUIRED_GO_MAJOR}.${REQUIRED_GO_MINOR} ..."
  local arch
  case "$(uname -m)" in
    x86_64)  arch=amd64 ;;
    aarch64) arch=arm64 ;;
    *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
  esac

  local tarball
  tarball="$(curl -fsSL 'https://go.dev/dl/?mode=json' \
    | grep -oP '"go[0-9]+\.[0-9]+\.[0-9]+\.linux-'"${arch}"'\.tar\.gz"' \
    | head -1 | tr -d '"')"

  if [ -z "$tarball" ]; then
    echo "Failed to determine latest Go tarball name." >&2
    exit 1
  fi

  echo "    Downloading ${tarball} ..."
  curl -fsSL "https://go.dev/dl/${tarball}" -o "/tmp/${tarball}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "/tmp/${tarball}"
  rm -f "/tmp/${tarball}"

  export PATH="/usr/local/go/bin:${PATH}"
  echo "    Installed: $(go version)"
}

# ---- main -------------------------------------------------------------------

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. Run tools/sandbox/install_docker.sh first." >&2
  exit 1
fi

if ! go_version_ok; then
  install_go
fi

# Ensure GOPATH/bin is on PATH for the current session.
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}"

echo "==> Cloning sandbox-codex into ${CLONE_DIR} ..."
mkdir -p "$(dirname "$CLONE_DIR")"
if [ -d "$CLONE_DIR/.git" ]; then
  echo "    Repository already exists — pulling latest changes."
  git -C "$CLONE_DIR" pull --ff-only origin main
else
  git clone --depth 1 "$REPO_URL" "$CLONE_DIR"
fi

echo "==> Building and installing codex-dock ..."
cd "$CLONE_DIR"
make build
sudo make install

echo "==> Installing default config ..."
make install-config

echo "==> Building codex-dock Docker images ..."
make docker
make proxy-docker

echo ""
echo "codex-dock installed successfully."
command -v codex-dock >/dev/null 2>&1 && echo "  binary : $(command -v codex-dock)"
echo "  config : ~/.config/codex-dock/config.toml"
echo "  source : ${CLONE_DIR}"
echo ""
echo "Next steps:"
echo "  codex-dock network create"
echo "  codex-dock proxy build && codex-dock proxy run"
echo "  codex-dock auth set   # set OPENAI_API_KEY / ANTHROPIC_API_KEY first"
echo "  codex-dock build && codex-dock run --agent claude"
