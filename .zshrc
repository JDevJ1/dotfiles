# PATH
typeset -U path
path+=($HOME/.local/bin $HOME/.dotnet/tools)

if ! command -v oh-my-posh >/dev/null 2>&1; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

#Fastfetch
command -v fastfetch >/dev/null 2>&1 && fastfetch

source "${ZINIT_HOME}/zinit.zsh"

# Add in completions (must be in fpath before compinit)
zinit light zsh-users/zsh-completions

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::dnf
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Add in zsh plugins (fzf-tab after compinit, syntax-highlighting last)
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Keybindings
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling (LS_COLORS is only set by /etc/profile in login shells)
[[ -z $LS_COLORS ]] && command -v dircolors >/dev/null 2>&1 && eval "$(dircolors -b)"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias k='kubectl'
alias tf='terraform'
alias x='exit'
alias repos='cd ~/source/repos'

# Shell integrations
command -v fzf >/dev/null 2>&1 && eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/json.omp.json)"

[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

autoload -U +X bashcompinit && bashcompinit
command -v terraform >/dev/null 2>&1 && complete -o nospace -C "$(command -v terraform)" terraform
