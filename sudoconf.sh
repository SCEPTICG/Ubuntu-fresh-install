#!/bin/bash

# MIRAMOS QUE EL SCRIPT SE EJECUTA COMO ROOT
if [[ $EUID -ne 0 ]]; then
  echo "Tienes que ser root para ejecutar este script, porfavor ejecuta sudo ./sudoconf.sh" 2>&1
  exit 1
fi

#HACEMOS UN LINK SYMBOLICO DE LA CONFIGURACIÓN DE ZSHRC Y CAMBIAMOS LA SHELL PARA ROOT
ln -s -f /home/scepticg/.zshrc /root/.zshrc
chsh -s $(which zsh)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
cp p10k.zsh ~/.p10k.zsh

#INSTALAMOS ASTROVIM PARA ROOT
mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync

#INSTALAMOS FZF PARA ROOT
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
exit