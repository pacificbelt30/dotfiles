#!/usr/bin/env bash
# Install Docker Engine on Ubuntu 24.04 (WSL2 / VM).
# Follows the official Docker docs: https://docs.docker.com/engine/install/ubuntu/
set -euo pipefail

if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed: $(docker --version)"
  exit 0
fi

if ! grep -qi ubuntu /etc/os-release 2>/dev/null; then
  echo "This script targets Ubuntu. Detected a different distro — aborting." >&2
  exit 1
fi

echo "==> Installing Docker Engine prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

echo "==> Adding Docker's official GPG key and apt repository..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Installing docker-ce packages..."
sudo apt-get update
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

echo "==> Adding current user ($(whoami)) to the docker group..."
sudo usermod -aG docker "$(whoami)"

# WSL2: systemd may or may not be enabled.  Try starting the service;
# if systemctl isn't available fall back to the legacy init script.
if command -v systemctl >/dev/null 2>&1 && systemctl is-system-running &>/dev/null; then
  sudo systemctl enable --now docker
else
  sudo service docker start 2>/dev/null || true
  echo "NOTE: systemd is not running (common on WSL2 without [boot] systemd=true)."
  echo "      Docker was started via 'service docker start'."
  echo "      To enable systemd, add the following to /etc/wsl.conf and restart WSL:"
  echo "        [boot]"
  echo "        systemd=true"
fi

echo ""
echo "Docker installed successfully: $(docker --version)"
echo "Log out and back in (or run 'newgrp docker') for group changes to take effect."
