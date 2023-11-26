FROM ubuntu:latest

ARG USER_ID
ARG GROUP_ID

# Update system and install packages.
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y software-properties-common && \
add-apt-repository ppa:neovim-ppa/unstable
RUN apt update -y && apt install -y \
pkg-config sudo bash curl wget fuse git fish tmux unzip \
gcc meson nodejs npm lua5.3 make cmake default-jdk neovim \
xauth libglfw3 libglfw3-dev \
libc6-dev libgl1-mesa-dev libxcursor-dev libxi-dev \ 
libxinerama-dev libxrandr-dev libxxf86vm-dev libasound2-dev

# Install Starship
# Holy shit.
RUN curl -LO https://github.com/starship/starship/releases/latest/download/starship-aarch64-unknown-linux-musl.tar.gz
RUN tar -xvzf starship-aarch64-unknown-linux-musl.tar.gz
RUN mv starship /usr/bin/ && rm starship-aarch64-unknown-linux-musl.tar.gz

# Ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
RUN dpkg -i ripgrep_13.0.0_amd64.deb && rm ripgrep_13.0.0_amd64.deb

# Craete user.
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID --shell /bin/sh user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user

# Starship Config
RUN mkdir ~/.config
RUN mkdir ~/.config/fish && touch ~/.config/fish/config.fish
RUN echo 'starship init fish | source' >> ~/.config/fish/config.fish

# Tmux Config
RUN git clone https://gitlab.com/Moncii/tmux-config.git ~/.config/tmux

# AstroVim
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

WORKDIR /proj

ENV DISPLAY=:0
ENTRYPOINT ["tmux"]
