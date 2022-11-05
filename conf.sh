#!/bin/bash

#ACTUALIZAMOS UBUNTU
sudo apt update 
sudo apt upgrade -y

#INSTALAR FIREFOX COMO .DEB
sudo snap remove firefox
#Añadimos el ppa de Mozilla Team
sudo add-apt-repository ppa:mozillateam/ppa -y
#Cambiamos la prioridad del paquete para que use el ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
#Nos aseguramos que las actualizaciones se hagan automaticamente
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

#AÑADIMOS LOS PPA QUE NECESTIAMOS
#Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
#Vscode
sudo apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

#INSTALAMOS TODOS LOS PAQUETES
sudo apt update
sudo apt install firefox neovim code nala virtualbox git kitty -y

#DESCARGAMOS E INSTALAMOS NERDFONTS
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
rm -rf nerd-fonts

#INSTALAMOS LUNARVIM PARA NEOVIM 0.9
sudo apt install curl nodejs npm python3-pip build-essential gcc make -y
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.profile
npm install -g jshint
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
