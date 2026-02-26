# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/src/flux-config:$(go env GOPATH)/bin

# Fix colors in terminal
export TERM=xterm-kitty

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  sudo
)

source $ZSH/oh-my-zsh.sh

# Fix GPG interface with Yubikey
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"

# Keybindings for moving around in the terminal
bindkey "^[[1;4D" backward-kill-word
bindkey "^[[1;4C" kill-word

# OS Specific configuration
if [ "$OSTYPE" = "linux-gnu" ]; then
  echo "Configuring Linux-specific settings"
  # Keybindings for jumping around in text
  bindkey "^[[1;3D" backward-word
  bindkey "^[[1;3C" forward-word
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
else
  echo "Configuring Mac-specific settings"
  # Keybindings for jumping around in text
  bindkey "^[^[[D" backward-word
  bindkey "^[^[[C" forward-word
fi

# Prune all merged branches in git
echo "Setting up git functions"
pruneGitBranches() {
  emulate -L zsh
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1
  git fetch --prune -q

  local mode=merged force=0 dry=0 opt
  while getopts "gafn" opt; do
    [[ $opt == g ]] && mode=gone
    [[ $opt == a ]] && mode=all
    [[ $opt == f ]] && force=1
    [[ $opt == n ]] && dry=1
  done

  local cur=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
  local -a del
  if [[ $mode == merged ]]; then
    del=("${(@f)$(git branch --format='%(refname:short)' --merged origin/master \
            | grep -vE "^(${cur}|master)$")}")
  elif [[ $mode == gone ]]; then
    del=("${(@f)$(git for-each-ref --format='%(upstream:trackshort) %(refname:short)' refs/heads \
            | awk '$1=="[gone]" {print $2}' \
            | grep -vE "^(${cur}|master)$")}")
  else # all
    del=("${(@f)$(git for-each-ref --format='%(refname:short)' refs/heads \
            | grep -vE "^(${cur}|master)$")}")
  fi

  [[ -z ${del[1]-} ]] && { echo "Nothing to prune."; return 0; }

  echo "Merged branches to delete:"
  printf '  %s\n' "${del[@]}"

  (( dry )) && return 0
  if read -q "REPLY?Delete ${#del} branches [y/N]? "; then
    echo
    if (( force )); then git branch -D -- "${del[@]}"; else git branch -d -- "${del[@]}"; fi
  else
    echo
  fi
}

# Switch between Eldritch and Rosepine (and Neovim versions)
function theme {
  echo "Select Neovim and theme version (nvim = Eldritch, nvim-nightly = Rosepine)"
  select config in nvim nvim-nightly; do
  case $config in
    nvim)
      if [[ $NVIM_APPNAME == "" ]]; then
        echo "Already using nvim theme"
        break
      fi
      # Use stable version of nvim
      bob use stable
      unset NVIM_APPNAME
      # Update Oh-My-Posh terminal line
      eval "$(oh-my-posh init zsh -c ~/.zsh/eldritch.toml)"
      # Update kitty theme
      kitty +kitten themes --reload-in=all Eldritch
      # Update k9s theme
      if [ "$OSTYPE" != "linux-gnu" ]; then
        sed -i "" -i "s/skin: rosepine/skin: eldritch/g" $HOME/.config/k9s/config.yaml
        sed -i "" -i '/NVIM_APPNAME/d' $HOME/.zshenv
      else
        sed -i "s/skin: rosepine/skin: eldritch/g" $HOME/.config/k9s/config.yaml
      fi
      ;;
    nvim-nightly)
      if [[ $NVIM_APPNAME == "nvim-nightly" ]]; then
        echo "Already using nvim-nightly theme"
        break
      fi
      # Use nightly version of nvim
      bob use nightly
      export NVIM_APPNAME="nvim-nightly"
      echo "NVIM_APPNAME=\"nvim-nightly\"" >> $HOME/.zshenv
      # Update Oh-My-Posh terminal line
      eval "$(oh-my-posh init zsh -c ~/.zsh/rosepine.omp.json)"
      # Update kitty theme
      kitty +kitten themes --reload-in=all Rosé\ Pine\ Moon
      # Update k9s theme
      if [ "$OSTYPE" != "linux-gnu" ]; then
        sed -i "" -i "s/skin: eldritch/skin: rosepine/g" $HOME/.config/k9s/config.yaml
      else
        sed -i "s/skin: eldritch/skin: rosepine/g" $HOME/.config/k9s/config.yaml
      fi
      ;;
  esac
  break; done
}

# Start the SSH agent
echo "Starting the GPG SSH agent"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
unset SSH_AGENT_PID

## ALIASES
# Prettify listing files
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto --group-directories-first' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs

# Special git aliases
alias gr="gco master && git pull --prune && pruneGitBranches"
alias gpb="pruneGitBranches -a"
alias grb="git fetch origin && git rebase origin/HEAD"

# Helpers
alias nvim="$HOME/.local/share/bob/nvim-bin/nvim"
alias vim="nvim"
alias vi="vim"
alias vimdiff="nvim -d"
alias k="kubectl"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias sourceme="source ~/src/source_me.sh"

TERRAFORM=$(which tofu || which terraform)
alias tf="$TERRAFORM"
alias tft="tf fmt **/*.tf"
alias fluxsync="flux reconcile source git flux2-sync && flux reconcile kustomization flux2-sync && flux reconcile kustomization cluster-critical-kustomization && flux reconcile kustomization platform-kustomization"

# environment variables
export K9S_CONFIG_DIR="$HOME/.config/k9s"
export K9S_EDITOR="nvim"
export KUBE_EDITOR="nvim"
export NVIM_APPNAME="nvim-nightly"

# Import sensitive aliases
SENSITIVE="$HOME/.zshrc.sensitive"
if [ -f $SENSITIVE ]; then
  echo "Sourcing sensitive config"
  source $SENSITIVE
fi

# Import work specific
if [ "$OSTYPE" != "linux-gnu" ]; then
  echo "Sourcing work config"
  source "$HOME/.zshrc.work"
fi

## For Gemini support
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"

# Make sure this is last
echo "Adding flux completion"
. <(flux completion zsh)
echo "Adding kubernetes completion"
. <(k completion zsh)
echo "Adding istio completion"
. <(istioctl completion zsh)
echo "Adding bob completion"
. <(bob complete zsh)
echo "Adding gatekeeper completion"
. <(gatekeeper completion zsh)
echo "Adding zoxide"
eval "$(zoxide init zsh)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  echo "Adding oh-my-posh"
  eval "$(oh-my-posh init zsh --config $HOME/.zsh/rosepine.omp.json)"
  alias gcli='tmux attach -t gemini || tmux new -s gemini'
fi

# Gemini Sandbox Configuration
export GOOGLE_CLOUD_PROJECT="gemini-code-assist-b4b3"
