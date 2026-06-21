#!/usr/bin/env bash
# Install nvm (https://github.com/nvm-sh/nvm) and the latest LTS Node.js.
# nvm replaces system node/npm for this dotfiles setup.
set -euo pipefail

NVM_VERSION="${NVM_VERSION:-v0.40.1}"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "nvm is already installed in $NVM_DIR"
else
  echo "Installing nvm ${NVM_VERSION}..."
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
fi

# shellcheck source=/dev/null
. "$NVM_DIR/nvm.sh"

echo "Installing latest LTS Node.js..."
nvm install --lts
nvm alias default 'lts/*'

echo "Done. node: $(node --version), npm: $(npm --version)"
