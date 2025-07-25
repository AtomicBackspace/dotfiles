# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/src/flux-config

# Fix colors in terminal
export TERM=xterm-kitty

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Fix GPG interface with Yubikey
export GPG_TTY=$(tty)
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="vim"
export VISUAL="vim"

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
function pruneMergedGitBranches {
  if read -q "choice?Do you want to prune all merged branches? (y/Y for yes): "; then
    git branch -D `git branch --merged | grep -v \* | xargs`
  else
    echo 
    echo "'$choice' not 'Y' or 'y'. Exiting..."
  fi
}


# Start the SSH agent
eval "$(ssh-agent -s)"

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
alias k="kubectl"
alias fzfp="fzf --preview 'bat --color=always {}'"
alias sourceme="source ~/src/source_me.sh"

TERRAFORM=$(which terraform || which tofu)
alias tf="$TERRAFORM"
alias tft="tf fmt **/*.tf"
alias fluxsync="flux reconcile source git flux2-sync && flux reconcile kustomization flux2-sync && flux reconcile kustomization cluster-critical-kustomization && flux reconcile kustomization platform-kustomization"

# environment variables
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Import sensitive aliases
SENSITIVE="$HOME/.zshrc.sensitive"
if [ -f $SENSITIVE ]; then
  source $SENSITIVE
fi

# Import work specific
if [ "$OSTYPE" != "linux-gnu" ]; then
  source "$HOME/.zshrc.work"
fi

# Make sure this is last
export PATH="$PATH:$(go env GOPATH)/bin:${KREW_ROOT:-$HOME/.krew}/bin"
. <(flux completion zsh)
. <(k completion zsh)
. <(istioctl completion zsh)
eval "$(zoxide init zsh)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.zsh/ohmyposh.toml)"
fi
