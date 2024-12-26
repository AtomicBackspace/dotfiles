#!/bin/bash

# Programs
yay -S \
  stow \
  vim \
  kitty \
  keepassxc \
  eza \
  OpenTabletDriver \
  opentofu-bin \
  krunner \
  tor \
  tmux \
  pre-commit \
  sops \
  bat \
  fzf \
  zoxide \
  sparrow-wallet


# Other installs
systemctl enable tor
systemctl start tor

# ZSH 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh-256color zsh-autosuggestionts zsh-syntax-highlighting

# Oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install meslo
