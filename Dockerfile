FROM ubuntu:latest

ARG USER_ID
ARG GROUP_ID

# Update system and install packages.
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y software-properties-common && \
add-apt-repository ppa:neovim-ppa/unstable
RUN apt update -y && apt install -y \
pkg-config sudo bash curl wget git zsh tmux neovim unzip \
gcc meson nodejs npm golang-go python lua5.3 make cmake default-jdk \
xauth libglfw3 libglfw3-dev libc6-dev libgl1-mesa-dev \
libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev \
libxxf86vm-dev libasound2-dev libglu1-mesa-dev \
mesa-common-dev xorg-dev

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

# ZVM (Zig Version Manager)
RUN curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
RUN echo "# ZVM" >> $HOME/.profile \
echo export ZVM_INSTALL="$HOME/.zvm/self" >> $HOME/.profile \
echo export PATH="$PATH:$HOME/.zvm/bin" >> $HOME/.profile \
echo export PATH="$PATH:$ZVM_INSTALL/" >> $HOME/.profile
RUN source ~/.profile

### Configs ###
RUN mkdir ~/.config

# ZSH
RUN echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Tmux
RUN git clone https://gitlab.com/Moncii/tmux-config.git ~/.config/tmux

# AstroVim
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

WORKDIR /proj

ENTRYPOINT ["zsh"]
