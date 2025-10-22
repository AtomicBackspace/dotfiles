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
function pruneMergedGitBranches {
  if read -q "choice?Do you want to prune all merged branches? (y/Y for yes): "; then
    git branch -D `git branch --merged | grep -v \* | xargs`
  else
    echo
    echo "'$choice' not 'Y' or 'y'. Exiting..."
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
      kitty +kitten themes --reload-in=all Rosé\ Pine
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
alias gr="gco master; git pull --prune"
alias gpb="pruneMergedGitBranches"

# Helpers
alias vim="nvim"
alias vi="vim"
alias vimdiff="nvim -d"
alias k="kubectl"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias sourceme="source ~/src/source_me.sh"

TERRAFORM=$(which terraform || which tofu)
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

# Make sure this is last
echo "Adding flux completion"
. <(flux completion zsh)
echo "Adding kubernetes completion"
. <(k completion zsh)
echo "Adding istio completion"
. <(istioctl completion zsh)
echo "Adding zoxide"
eval "$(zoxide init zsh)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  echo "Adding oh-my-posh"
  eval "$(oh-my-posh init zsh --config $HOME/.zsh/rosepine.omp.json)"
fi
