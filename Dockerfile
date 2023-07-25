FROM alpine:latest

WORKDIR /proj

# Update and install packages.
RUN apk update && apk upgrade
RUN apk add --no-cache \
xauth mesa mesa-utils mesa-gl mesa-dri-gallium \
go gcc neovim git fish starship tmux nodejs npm curl lua5.3

# Starship Prompt
RUN mkdir -p ~/.config
RUN mkdir -p ~/.config/fish && echo "starship init fish | source" >> ~/.config/fish/config.fish
RUN starship preset nerd-font-symbols -o ~/.config/starship.toml

# Config Files
RUN git clone https://gitlab.com/Moncii/minimal.nvim.git
RUN mkdir -p ~/.config && mv minimal.nvim ~/.config/nvim

ENV DISPLAY=:0
ENTRYPOINT ["fish"]
