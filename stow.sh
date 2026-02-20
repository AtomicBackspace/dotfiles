#!/bin/bash

# Install tmux
stow -t $HOME tmux

# Install zsh config
stow -t $HOME zsh
#stow -t $HOME/.zsh oh-my-posh

# Install kitty config
mkdir -p $HOME/.config/kitty
stow -t $HOME/.config/kitty kitty

# Install VIM config and plugins
mkdir -p $HOME/.config/{nvim,nvim-nightly}
#stow -t $HOME/.config/nvim nvim
stow -t $HOME/.config/nvim-nightly nvim-nightly

# Install editorconfig
stow -t $HOME misc_home

# Install gpg config for allowing Yubikeys
if [ $(uname) == "Darwin" ]; then
  stow -t $HOME/.gnupg gnupg_mac
else
  stow -t $HOME/.gnupg gnupg_linux
fi

# Install k9s customization
mkdir -p $HOME/.config/k9s
stow -t $HOME/.config/k9s k9s

# Install hexchat
mkdir -p $HOME/.config/hexchat
stow --adopt -t $HOME/.config/hexchat hexchat

# Install mpv
mkdir -p $HOME/.config/mpv
stow -t $HOME/.config/mpv mpv

# Install gemini
mkdir -p $HOME/.gemini
stow -t $HOME/.gemini gemini --adopt
