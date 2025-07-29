#!/bin/bash

# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Fonts

brew install \
  zsh \
  jandedobbeleer/oh-my-posh/oh-my-posh \
  stow \
  neovim \
  kitty \
  keepassxc \
  eza \
  tmux \
  pre-commit \
  ripgrep \
  fd \
  the_silver_searcher \
  sops \
  bat \
  fzf \
  zoxide \
  fluxcd/tap/flux \
  opentofu-bin \
  bash-language-server \
  lua-language-server \
  yaml-language-server \
  derailed/popeye/popeye \
  clang \
  go

# ZSH 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fonts
oh-my-posh font install meslo
oh-my-posh font install JetBrainsMono

# Install Go LSP
go install golang.org/x/tools/gopls@latest
