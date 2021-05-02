#!/usr/bin/env bash
set -euo pipefail

export ZSH="$HOME/.config/omzsh"
export NVM_DIR="$HOME/.config/nvm"
export ADOTDIR="$HOME/.config/antigen/"

sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh build-essential git stow curl gcc python neovim
chsh -s $(which zsh)
if [[ -f "$HOME/.profile" ]]; then
  rm $HOME/.profile
fi
echo "Installing dotfiles"
git clone https://github.com/ozakione/dotfiles .dotfiles
cd .dotfiles
stow p10k

cd $HOME
mkdir .cache

# nvm
echo "Installing nvm"
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
. "$NVM_DIR/nvm.sh"
 
# omzsh
echo "Installing omzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
if [[ -f "$HOME/.zshrc" ]]; then
  rm $HOME/.zshrc
fi

# antigen
echo "Installing antigen"
mkdir $ADOTDIR
curl -L git.io/antigen > ${ADOTDIR}antigen.zsh
if [[ -f "$HOME/.zshrc.pre-oh-my-zsh" ]]; then
  rm $HOME/.zshrc.pre-oh-my-zsh
fi
if [ `ls -1 $HOME/.bash* 2>/dev/null | wc -l ` -gt 0 ]; then
  rm $HOME/.bash*
fi
cd $HOME/.dotfiles
stow *
stow -D git
echo "Now type exit and open again wsl"