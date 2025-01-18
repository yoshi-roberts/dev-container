FROM ubuntu:latest
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu

ARG USER_ID
ARG GROUP_ID

ENV TERM=xterm-256color

# Update system and install packages.
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable

RUN apt update -y && apt install -y \
pkg-config apt-utils sudo bash curl wget zip unzip git \
zsh tmux stow neovim trash-cli eza bat ripgrep \
ruby-full build-essential zlib1g-dev \
locales gcc meson golang-go python3 python3-venv lua5.3 make cmake openjdk-17-jdk \
xsel xauth libglfw3 libglfw3-dev libc6-dev libgl1-mesa-dev \
libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev \
libxxf86vm-dev libasound2-dev libglu1-mesa-dev \
mesa-common-dev xorg-dev

# Set the locale.
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Get more up to date Node version.
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -y && apt-get install nodejs -y

# Create user.
RUN groupadd --gid $GROUP_ID dev
RUN adduser --disabled-password --gecos '' -uid $USER_ID --gid $GROUP_ID --shell /usr/bin/zsh dev
RUN usermod -aG sudo dev
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER dev

### Configs ###
RUN mkdir -p ~/.config
RUN git clone -b dev-env https://github.com/ezri-roberts/dotfiles.git ~/dotfiles
RUN cd ~/dotfiles && stow . && cd

# FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN yes | ~/.fzf/install

# Add ruby to path
RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
RUN echo 'export PATH=$PATH:$HOME/gems/bin' >> ~/.zshrc

# Nvim Config
RUN git clone https://github.com/ezri-roberts/nvim-config.git ~/.config/nvim

WORKDIR /home/dev/proj

ENTRYPOINT ["zsh"]
