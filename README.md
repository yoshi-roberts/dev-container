### About

My development environment inside a docker container.<br>
This allows me to not clutter my host system with project dependencies and tools.<br>

### Included

These are some of the included tools:

- go
- gcc
- git
- lua
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

#### Initial Run
```zsh
docker run --name=dev \
    --mount type=bind,source=/home/"$(whoami)"/Dir,target=/home/user/proj \
    -it dev:latest
```

#### Starting
```zsh
docker start -i dev
```

