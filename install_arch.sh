#!/bin/bash

# Programs
yay -S \
  stow \
  neovim \
  kitty \
  keepassxc \
  eza \
  OpenTabletDriver \
  opentofu-bin \
  krunner \
  tor \
  tmux \
  pre-commit \
  ripgrep \
  fd \
  sops \
  bat \
  fzf \
  zoxide \
  flux-bin \
  sparrow-wallet \
  go \
  clang \
  bash-language-server \
  lua-language-server \
  yaml-language-server \
  xclip 


# Other installs
systemctl enable tor
systemctl start tor

# ZSH 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh-256color zsh-autosuggestionts zsh-syntax-highlighting

# Oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install meslo

# Install Go LSP
go install golang.org/x/tools/gopls@latest

# Install popeye
go install github.com/derailed/popeye@latest
