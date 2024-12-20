#!/bin/bash

# Install tmux
stow -t $HOME tmux

# Install zsh config
stow -t $HOME zsh

# Install kitty config
mkdir -p $HOME/.config/kitty
stow -t $HOME/.config/kitty kitty

# Install VIM config and plugins
stow -t $HOME vim

# Clone repositories
mkdir -p $HOME/.vim/pack/{dist,plugins,tpope}/start

cd $HOME/.vim/pack/dist/start
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/vim-airline/vim-airline-themes.git

cd $HOME/.vim/pack/plugins/start
git clone https://github.com/prettier/vim-prettier
git clone https://github.com/hashivim/vim-terraform.git

cd $HOME/.vim/pack/tpope/start
git clone https://github.com/tpope/vim-commentary.git
