# Disposable sandbox environment for the `sand` command (tools/sandbox/sand.sh).
#
# Mirrors the host shell setup (zsh + starship, uv-managed Python, nvm-managed
# Node.js, the pwn(CTF) venv, pwndbg, common binary-analysis CLI tools)
# without the desktop pieces (i3/picom/rofi/terminator), which don't apply
# inside a container. Ghidra is a GUI app and is intentionally left out here;
# install it on the host with tools/rev/install_ghidra.sh instead.
#
# Build context must be the repo root (tools/sandbox/sand.sh does this).

FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
# nvm.sh relies on bash-isms; make RUN use bash instead of the default dash.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl ca-certificates unzip build-essential sudo \
        zsh tmux vim neovim \
        gdb file binutils \
        ripgrep fd-find bat hexyl binwalk \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
# ubuntu:24.04 ships a pre-created "ubuntu" user at UID 1000; drop it if it
# collides with the UID we want to use for "sandbox".
# pwndbg's setup.sh (below) shells out to `sudo apt-get install` for its own
# build deps, so the sandbox user needs passwordless sudo inside the container.
RUN if getent passwd "${UID}" >/dev/null; then userdel -r "$(getent passwd "${UID}" | cut -d: -f1)"; fi \
    && useradd -m -u ${UID} -s /usr/bin/zsh sandbox \
    && echo "sandbox ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sandbox
USER sandbox
WORKDIR /home/sandbox
ENV PATH="/home/sandbox/.local/bin:${PATH}"

# fd/bat ship as fdfind/batcat on Ubuntu; expose the canonical names too,
# same as tools/cli/install_cli_tools.sh does on the host.
RUN mkdir -p ~/.local/bin \
    && ln -s "$(command -v fdfind)" ~/.local/bin/fd \
    && ln -s "$(command -v batcat)" ~/.local/bin/bat

# eza (ls/lt alias in shell/zsh/zshrc): install the release binary directly,
# since it isn't reliably available via apt across Ubuntu releases yet.
RUN ARCH="$(uname -m)" \
    && case "$ARCH" in \
         x86_64)  EZA_ARCH=x86_64-unknown-linux-gnu ;; \
         aarch64) EZA_ARCH=aarch64-unknown-linux-gnu ;; \
         *) echo "unsupported arch for eza: $ARCH" >&2; exit 1 ;; \
       esac \
    && curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${EZA_ARCH}.tar.gz" \
       | tar -xz -C ~/.local/bin ./eza

# starship (prompt)
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /home/sandbox/.local/bin

# python: uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# node: nvm
ENV NVM_DIR=/home/sandbox/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" && nvm install --lts && nvm alias default 'lts/*'

# pwndbg (gdb plugin, registers itself in ~/.gdbinit)
# setup.sh runs `uv sync` against a bare cwd-relative pyproject.toml, so it
# must be invoked from inside the cloned repo, not by absolute path.
RUN git clone --depth 1 https://github.com/pwndbg/pwndbg /home/sandbox/.local/share/pwndbg \
    && cd /home/sandbox/.local/share/pwndbg && ./setup.sh

# checksec
RUN curl -fsSL https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec \
        -o /home/sandbox/.local/bin/checksec \
    && chmod +x /home/sandbox/.local/bin/checksec

# dotfiles: zsh/starship config + the pwn(CTF) python venv (pwntools/ptrlib/...)
COPY --chown=sandbox:sandbox shell/zsh/zshrc /home/sandbox/dotfiles/shell/zsh/zshrc
COPY --chown=sandbox:sandbox starship.toml /home/sandbox/dotfiles/starship.toml
COPY --chown=sandbox:sandbox lang/python/pwn /home/sandbox/dotfiles/lang/python/pwn
COPY --chown=sandbox:sandbox tools/ai/install_ai_clis.sh /home/sandbox/dotfiles/tools/ai/install_ai_clis.sh
RUN ln -s /home/sandbox/dotfiles/shell/zsh/zshrc /home/sandbox/.zshrc \
    && mkdir -p /home/sandbox/.config \
    && ln -s /home/sandbox/dotfiles/starship.toml /home/sandbox/.config/starship.toml \
    && /home/sandbox/dotfiles/lang/python/pwn/setup_pwn_env.sh

# AI coding CLIs (Claude Code, OpenAI Codex CLI)
RUN . "$NVM_DIR/nvm.sh" && /home/sandbox/dotfiles/tools/ai/install_ai_clis.sh

WORKDIR /work
CMD ["zsh"]
