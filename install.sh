#!/bin/bash

ln -sf $PWD/i3 ~/.config/i3
ln -sf $PWD/i3status ~/.config/i3status
ln -sf $PWD/kitty ~/.config/kitty
ln -sf $PWD/scripts ~/.config/scripts
ln -sf $PWD/vifm ~/.config/vifm
ln -sf $PWD/nvim ~/.config/nvim
ln -sf $PWD/tmux ~/.config/tmux
ln -sf $PWD/kazam ~/.config/kazam

ln -sf $PWD/.zshrc ~/.zshrc

sudo apt update
sudo apt upgrade -y

# sudo apt install nvidia-driver-570

sudo apt install -y \
   vim \
   i3 \
   ca-certificates \
   docker.io \
   docker-compose \
   nodejs \
   npm \
   wget \
   curl \
   zsh \
   vifm \
   ngrok \
   tmux \
   fzf \
   ripgrep \
   kazam \
   xclip \
   git \
   lazygit \
   tree \
   imagemagick \
   zoxide \
   zsh-autosuggestions \
   zsh-syntax-highlighting \
   steam \
   libvulkan1 \
   vulkan-tools \
   zbarimg \
   pass \
   pass-otp \
   ffmpeg \
   gpick \
   python3-pip \
   qbittorrent

# install neovim
wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.tar.gz
tar -xvf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install node
npm i -g typescript typescript-language-server yarn eslint n pnpm
sudo n latest

# install vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update
sudo apt install codium

# install postman 
wget https://dl.pstmn.io/download/latest/linux_64
sudo tar -xvf linux_64 -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm linux_64

# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
