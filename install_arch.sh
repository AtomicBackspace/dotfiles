#!/bin/bash

# Programs
yay -S \
  stow \
  vim \
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

# Install krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# Install popeye
go install github.com/derailed/popeye@latest
