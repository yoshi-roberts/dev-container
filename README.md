### About

This is my development environment inside a docker container.<br>
This allows you to not clutter your host system with project dependencies and tools.<br>
Also, this stops you from freezing your host system with shitty code!<br>

Building and running graphical applications is also supported.<br>
However, this requires running the container on a linux system running an x server.<br>

### Included

> Note that this is all running on a arch linux base image.


The shell is [fish](https://fishshell.com/) running the [starship](https://starship.rs/) prompt.<br>
The editor is [neovim](https://neovim.io/) using my own config.<br>

The following is also included.

- go
- lua
- love
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
docker run --name=dev --net host -v /tmp/.X11-unix:/tmp/.X11-unix/ --privileged -v $XAUTHORITY:/tmp/.XAuthority -e XAUTHORITY=/tmp/.XAuthority -v ~/HostFolder:/proj -it dev:latest
```

#### Starting
```
docker start -i dev
```
