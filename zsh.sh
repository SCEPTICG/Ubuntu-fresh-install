#!/bin/bash
cp zshrc ~/.zshrc
sudo apt install zsh-syntax-highlighting zsh-autosuggestions locate bat -y
sudo updatedb
sudo mkdir /usr/share/zsh-sudo
sudo chown scepticg:scepticg /usr/share/zsh-sudo
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
sudo mv sudo.plugin.zsh /usr/share/zsh-sudo
sudo dpkg -i lsd-musl_0.23.1_amd64.deb
rm lsd-musl_0.23.1_amd64.deb
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat