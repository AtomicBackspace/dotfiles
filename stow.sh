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

# Install editorconfig
stow -t $HOME misc_home

# Install gpg config for allowing Yubikeys
stow -t $HOME/.gnupg gnupg

# Clone repositories
mkdir -p $HOME/.vim/pack/{plugins,tpope}/start
mkdir -p $HOME/.vim/bundle

cd $HOME/.vim/bundle
if [ ! -d Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git
fi

cd $HOME/.vim/pack/plugins/start
if [ ! -d vim-terraform ]; then
  git clone https://github.com/hashivim/vim-terraform.git
fi

cd $HOME/.vim/pack/tpope/start
if [ ! -d vim-commentary ]; then
  git clone https://github.com/tpope/vim-commentary.git
fi
