# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Use direnv for venv activation
eval "$(direnv hook zsh)"

# aws profile switcher
function actx() {
  export AWS_PROFILE="$(aws configure list-profiles | fzf)"
  echo "Switched to profile ""$AWS_PROFILE""."
}

# Aliases
alias k="kubectl"
alias kns="kubens"
alias kctx="kubectx"
alias kevents="kubectl get events --sort-by='.lastTimestamp'"
alias kdrain="kubectl drain --ignore-daemonsets --delete-emptydir-data"
alias kcapacity="k resource-capacity --util"
alias g="git"
alias wip="git add . && git commit -m'wip' && git push"
alias vim="nvim"
alias vi="nvim"
alias clip='xclip -selection clipboard'
alias cb='git branch --sort=-committerdate | fzf --header Checkout --cycle | xargs git checkout'
alias pul='pulumi'
alias puls='pulumi stack select'
alias awsl='aws sso login'
# argo workflow submit
alias awfs='argo submit --wait --log'
#alias awslocal='aws --endpoint-url=http://localhost:4566'

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found


# Load completions
autoload -Uz compinit && compinit
#zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Disable beep
unsetopt beep

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Editor
export EDITOR='nvim'

# Rancher Desktop
export DOCKER_HOST="unix:///home/devon/.rd/docker.sock"

# pyenv setup
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"


# PATH changes
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin:$HOME/.pulumi/bin:/home/linuxbrew/.linuxbrew/bin"

# Oh-My-Posh Prompt 
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json)"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/devon/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
