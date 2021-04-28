#!/usr/bin/env bash
set -euo pipefail

sudo apt update && sudo apt upgrade
sudo apt install build-essential git stow curl gcc python -y
# install zsh

export EDITOR=code
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# antigen
curl -L git.io/antigen > antigen.zsh
# dotfiles
