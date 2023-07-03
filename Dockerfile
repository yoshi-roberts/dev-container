FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add --no-cache \
go gcc neovim git fish starship nodejs npm curl luajit \
alsa-lib-dev libx11-dev libxrandr-dev libxcursor-dev libxinerama-dev libxi-dev mesa-dev pkgconf

RUN mkdir -p ~/.config
RUN mkdir -p ~/.config/fish && echo "starship init fish | source" >> ~/.config/fish/config.fish
RUN starship preset nerd-font-symbols -o ~/.config/starship.toml

RUN git clone https://gitlab.com/Moncii/minimal.nvim.git
RUN mkdir -p ~/.config && mv minimal.nvim ~/.config/nvim

WORKDIR /proj

ENTRYPOINT [ "fish" ]
