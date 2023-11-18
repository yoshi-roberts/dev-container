FROM archlinux:latest

# Update and install packages.
RUN pacman-key --init
RUN pacman -Syu --noconfirm
RUN pacman -Syy --noconfirm
RUN pacman -S --noconfirm \
bpkgconf bash sudo curl wget git fish unzip \
go gcc zig nodejs npm lua make jdk-openjdk \
neovim

RUN pacman -Scc --noconfirm

WORKDIR /root/proj

# Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN mkdir ~/.config
RUN mkdir ~/.config/fish && touch ~/.config/fish/config.fish
RUN echo 'starship init fish | source' >> ~/.config/fish/config.fish

ENTRYPOINT ["fish"]
