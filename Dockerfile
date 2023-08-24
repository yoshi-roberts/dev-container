FROM alpine:latest

# Update and install packages.
RUN apk update && apk upgrade
RUN apk add --no-cache \
doas shadow xauth mesa mesa-utils mesa-gl mesa-dri-gallium \
go gcc neovim git fish starship tmux nodejs npm curl lua5.3

# User
RUN adduser -D dev -G wheel
RUN echo "permit nopass :wheel" > /etc/doas.d/doas.conf
COPY passwd /etc/passwd
USER dev

WORKDIR /home/dev/proj

# Config Files
RUN mkdir -p ~/.config

# Starship Prompt
RUN mkdir -p ~/.config/fish && echo "starship init fish | source" >> ~/.config/fish/config.fish
RUN starship preset nerd-font-symbols -o ~/.config/starship.toml

# Tmux
RUN mkdir ~/.config/tmux
COPY tmux.conf /home/dev/.config/tmux/tmux.conf

# Nvim
RUN git clone https://gitlab.com/Moncii/minimal.nvim.git ~/.config/nvim

ENV DISPLAY=:0
ENTRYPOINT ["fish"]
