FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl ca-certificates gnupg sudo \
        vim zsh neovim tmux build-essential \
    && rm -rf /var/lib/apt/lists/*

# Docker Engine (CLI + daemon socket will be mounted from the host at runtime)
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
       | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
       https://download.docker.com/linux/ubuntu noble stable" \
       > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       docker-ce-cli docker-buildx-plugin docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Go (for building codex-dock)
ARG GO_VERSION=1.24.7
RUN ARCH="$(dpkg --print-architecture)" \
    && curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz" \
       | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

ARG UID=1000
RUN if getent passwd "${UID}" >/dev/null; then \
      userdel -r "$(getent passwd "${UID}" | cut -d: -f1)"; \
    fi \
    && useradd -m -u ${UID} -s /usr/bin/zsh test \
    && echo "test ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/test
USER ${UID}
WORKDIR /home/test
ENV GOPATH="/home/test/go"
ENV PATH="${GOPATH}/bin:/home/test/.local/bin:${PATH}"

# dotfiles
RUN git clone --recursive https://github.com/pacificbelt30/dotfiles

# codex-dock: clone, build, install
RUN git clone --depth 1 https://github.com/pacificbelt30/sandbox-codex.git \
        /home/test/.local/share/codex-dock/src \
    && cd /home/test/.local/share/codex-dock/src \
    && make build \
    && sudo make install \
    && make install-config
