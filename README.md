### About

My development environment inside a docker container.<br>
Useful for not cluttering the host system with project dependencies and tools.<br>
> Note: This will not work on Windows due to the way volumes and user permissions are handled.

### Included

These are some of the included tools:

- go
- gcc
- lua
- git
- npm
- node
- java
- make
- cmake
- python
- neovim

The shell is [zsh](https://en.wikipedia.org/wiki/Z_shell)<br>

### Using

#### Build
```zsh
docker build -t dev:latest \
      --build-arg USER_ID=$(id -u) \
      --build-arg GROUP_ID=$(id -g) \
      --network=host .
```

#### Initial Start

Replace [DIR] with the directory you want to mount.
```zsh
docker run --name=dev \
    --mount type=bind,source=[DIR],target=/home/user/proj \
    -it dev:latest
```

#### Starting

Use this command to start the container after the initial start.
```zsh
docker start -i dev
```

