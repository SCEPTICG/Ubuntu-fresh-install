#!/bin/bash

#ACTUALIZAMOS UBUNTU
sleep 2
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
#Vscode
sudo apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

#INSTALAMOS TODOS LOS PAQUETES
sudo apt update
sudo apt install firefox code nala virtualbox git kitty neofetch -y
wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb

#DESCARGAMOS E INSTALAMOS NERDFONTS
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ..
rm -rf nerd-fonts

#INSTALAMOS ASTROVIM
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync

#CONFIGURAMOS KITTY
cp config/kitty ~/.config/kitty

#INSTALAMOS ZSH Y CONFIGURAMOS POWERLEVEL10K
sudo apt install zsh
chsh -s $(which zsh)
