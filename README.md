### About

This is my development environment inside a docker container.
This allows you to not clutter your host system with project dependencies and tools.
Also, this stops you from freezing your host system with shitty code!

Building and running graphical applications is also supported.
However, this requires running the container on a linux system running an x server.

### Included

> Note that this is all running on a alpine linux base image.

The shell is [fish](https://fishshell.com/) running the [starship](https://starship.rs/) prompt.
The editor is [neovim](https://neovim.io/) using my own config.

The following is also included.

- go
- lua
- gcc
- python
- node
- npm
- git

> These are just the tools I use. You can add whatever you like.

### Using

#### Build
```
docker build . -t dev:latest
```

#### Initial Run
```
docker run --name=dev --net host -v /tmp/.X11-unix:/tmp/.X11-unix/ --privileged -v $XAUTHORITY:/tmp/.XAuthority -e XAUTHORITY=/tmp/.XAuthority -v ~/proj:/proj -it dev:latest
```

#### Starting
```
docker start -i dev
```
