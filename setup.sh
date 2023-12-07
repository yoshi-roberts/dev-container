
# Update system and install packages.
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y software-properties-common && \
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update -y && sudo apt install -y \
net-tools pkg-config software-properties-common curl wget git zsh unzip tmux \
neovim gcc meson nodejs npm golang-go python3 lua5.3 make cmake default-jdk \
xauth libglfw3 libglfw3-dev libc6-dev libgl1-mesa-dev \
libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev \
libxxf86vm-dev libasound2-dev libglu1-mesa-dev \
mesa-common-dev xorg-dev

# Get more up to date Node version.
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update -y
sudo apt-get install nodejs -y

# Ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
dpkg -i ripgrep_13.0.0_amd64.deb && rm ripgrep_13.0.0_amd64.deb

### Configs ###
mkdir ~/.config

# ZSH
chsh -s /bin/zsh
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
git clone https://gitlab.com/Moncii/zsh-config.git ~/.config/zsh
ln -s ~/.config/zsh/zshrc ~/.zshrc
echo export LC_ALL=en_IN.UTF-8 >> $HOME/.profile
echo export LANG=en_IN.UTF-8 >> $HOME/.profile

# Tmux
git clone https://gitlab.com/Moncii/tmux-config.git ~/.config/tmux

# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
