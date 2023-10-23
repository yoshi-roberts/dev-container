FROM archlinux:latest

# Update and install packages.
RUN pacman-key --init
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm \
bash xorg-xauth sudo curl wget git fish unzip \
go gcc zig nodejs npm lua make \
jre-openjdk jdk-openjdk \
mesa mesa-utils \
neovim love

RUN pacman -Scc --noconfirm

WORKDIR /proj

# Install LazyVim config.
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
RUN rm -rf ~/.config/nvim/.git

# Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN mkdir ~/.config/fish && touch ~/.config/fish/config.fish
RUN echo 'starship init fish | source' >> ~/.config/fish/config.fish

ENV DISPLAY=:0
ENTRYPOINT ["fish"]
