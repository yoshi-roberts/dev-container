FROM ubuntu:latest

ARG USER_ID
ARG GROUP_ID

# Update system and install packages.
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y \
pkg-config sudo bash curl wget fuse git fish unzip \
gcc meson nodejs npm lua5.3 make default-jdk \
xauth libglfw3 libglfw3-dev \
libc6-dev libgl1-mesa-dev libxcursor-dev libxi-dev \ 
libxinerama-dev libxrandr-dev libxxf86vm-dev libasound2-dev

# Craete user.
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID --shell /bin/sh user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user

# Latest Neovim
RUN sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN sudo chmod +x nvim.appimage
RUN sudo mv nvim.appimage /usr/bin/nvim

# Starship
RUN sudo curl -LO https://github.com/starship/starship/releases/latest/download/starship-aarch64-unknown-linux-musl.tar.gz
RUN sudo tar -xvzf starship-aarch64-unknown-linux-musl.tar.gz
RUN sudo mv starship /usr/bin/ && rm starship-aarch64-unknown-linux-musl.tar.gz
RUN mkdir ~/.config
RUN mkdir ~/.config/fish && touch ~/.config/fish/config.fish
RUN echo 'starship init fish | source' >> ~/.config/fish/config.fish

WORKDIR /proj

ENTRYPOINT ["fish"]
