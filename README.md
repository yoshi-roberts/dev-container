### About

This is my development environment inside a docker container.<br>
This allows you to not clutter your host system with project dependencies and tools.<br>

### Included

The following tools are included.

- go
- lua
- gcc
- zig
- python
- node
- npm
- git
- neovim

The shell is [zsh](https://en.wikipedia.org/wiki/Z_shell)<br>
Neovim is using the [AstroNvim](https://astronvim.com/) configuration.<br>

> These are just the tools I use. You can add whatever you like.

### Using

#### Build
```
docker build -t dev:latest \
      --build-arg USER_ID=$(id -u) \
      --build-arg GROUP_ID=$(id -g) .
```

#### Initial Run
```
docker run --name=dev --net=host --mount type=bind,source=/home/"$(whoami)"/Dir,target=/home/user/proj -it dev:latest
```

#### Starting
```
docker start -i dev
```
