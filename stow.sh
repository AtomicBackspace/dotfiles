#!/bin/bash

# Install tmux
stow -t $HOME tmux

# Install zsh config
stow -t $HOME zsh

# Install kitty config
mkdir -p $HOME/.config/kitty
stow -t $HOME/.config/kitty kitty

# Install VIM config and plugins
mkdir -p $HOME/.config/{nvim,nvim-nightly}
stow -t $HOME/.config/nvim nvim
stow -t $HOME/.config/nvim-nightly nvim-nightly

# Install editorconfig
stow -t $HOME misc_home

# Install gpg config for allowing Yubikeys
stow -t $HOME/.gnupg gnupg

# Install k9s customization
mkdir -p $HOME/.config/k9s
stow -t $HOME/.config/k9s k9s

# Install hexchat
mkdir -p $HOME/.config/hexchat
stow -t $HOME/.config/hexchat hexchat

# Install mpv
mkdir -p $HOME/.config/mpv
stow -t $HOME/.config/mpv mpv
