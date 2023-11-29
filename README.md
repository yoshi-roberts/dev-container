### About

This is my development environment inside a docker container.<br>
This allows you to not clutter your host system with project dependencies and tools.<br>
Also, this stops you from freezing your host system with shitty code!<br>

### Included

The shell is [fish](https://fishshell.com/) running the [starship](https://starship.rs/) prompt.<br>
The editor is [neovim](https://neovim.io/) using my own config.<br>

The following is also included.

- go
- lua
- gcc
- zig
- python
- node
- npm
- git

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
docker run --name=dev --net=host --mount "type=bind,src=/home/$(whoami)/Dir,dst=/proj" -it dev:latest
```

#### Starting
```
docker start -i dev
```
