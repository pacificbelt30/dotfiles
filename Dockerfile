FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y git vim zsh curl neovim
ARG UID=1000
RUN useradd -m test -u ${UID}
USER ${UID}
WORKDIR /home/test
RUN git clone https://github.com/pacificbelt30/dotfiles
