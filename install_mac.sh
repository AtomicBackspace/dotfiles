#!/bin/bash

# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install \
  zsh \
  jandedobbeleer/oh-my-posh/oh-my-posh \
  stow \
  vim \
  kitty \
  keepassxc \
  eza \
  tmux \
  pre-commit \
  sops \
  opentofu-bin

# ZSH 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fonts
oh-my-posh font install meslo
