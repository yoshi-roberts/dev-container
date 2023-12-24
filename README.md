### About

This is my development environment inside a docker container.<br>
This allows you to not clutter your host system with project dependencies and tools.<br>

### Included

These are some of the included tools:

- go
- node
- npm
- zig
- gcc
- python
- lua
- git
- neovim

The shell is [zsh](https://en.wikipedia.org/wiki/Z_shell)<br>
Neovim is using the [AstroNvim](https://astronvim.com/) configuration.<br>

> These are just the tools I use. You can add whatever you like.

### Using

#### Build
```zsh
docker build -t dev:latest \
      --build-arg USER_ID=$(id -u) \
      --build-arg GROUP_ID=$(id -g) .
```

#### Initial Run
```zsh
docker run --name=dev --net=host -e "TERM=xterm-256color" --mount type=bind,source=/home/"$(whoami)"/Dir,target=/home/user/proj -it dev:latest
```

#### Starting
```zsh
docker start -i dev
```

