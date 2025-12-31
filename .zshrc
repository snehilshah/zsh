#!/usr/bin/env bash
# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# the path for .zshrc is set in zshenv in the folder /etc/zshenv
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"
# ZSH_THEME="robbyrussell" # moving to oh-my-posh
HYPHEN_INSENSITIVE="true"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':omz:update' mode reminder # just remind me to update when it's time
zstyle ':completion:*' menu select

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

setopt HIST_IGNORE_DUPS
setopt ALWAYS_TO_END
setopt APPEND_HISTORY
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
ulimit -S -n 2048

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Custom folder for oh-my-zsh (same git repo as zsh config)
ZSH_CUSTOM="$HOME/.config/zsh/custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node kubectl zsh-autosuggestions golang zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You need to manually build the locale first, in ubuntu you can `sudo nano /etc/locale.gen`, and then uncomment your locale, then just `sudo locale-gen`
# You may need to manually set your language environment
export LANG=en_IN.UTF-8
export LANGUAGE=en_IN.UTF-8
export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"
export TERM=xterm-256color

path+=('/usr/local/go/bin')
path+=('/home/srshah/go/bin')
path+=('/home/srshah/.local/bin')
path+=('/home/srshah/go/bun')
path+=('/home/srshah/.cargo/bin')
path+=('/home/srshah/.bun/bin')
export PATH

alias ls="eza"
alias cat="bat"
alias du="dust"
alias explorer="yazi"
alias vi="nvim"
alias nv="nvim"
alias find="fd"
# alias grep="rg"

# ZSH Paths
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.config/zsh/.zsh_history

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

bindkey '^[^M' autosuggest-accept
bindkey '^[f' forward-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

fzf() {
   case "$1" in
      --bash|--zsh|--fish|--version|-h|--help|--man)
         command fzf "$@"
         ;;
      *)
         fzf-zellij "$@"
         ;;
   esac
}

# eval "$(zellij setup --generate-auto-start zsh)"
# source <(fzf --zsh)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# zellij hack to rename tabs
if [[ -n "$ZELLIJ" ]]; then
  zellij_tab_name_update_preexec() {
    local cmd_line="$1"
    local cmd=""
    local max_len=15
    
    # Skip wrapper commands and get the actual command
    local words=(${(z)cmd_line})
    for word in "${words[@]}"; do
      case "$word" in
        sudo|watch|nohup|time|nice|ionice|strace|ltrace|env|command|exec|busybox)
          continue
          ;;
        -*)
          continue  # Skip flags
          ;;
        *)
          cmd="$word"
          break
          ;;
      esac
    done
    
    # Truncate if too long
    if [[ ${#cmd} -gt $max_len ]]; then
      cmd="${cmd:0:$max_len}.."
    fi
    
    if [[ -n "$cmd" ]]; then
      command zellij action rename-tab "$cmd" &>/dev/null
    fi
  }
  
  zellij_tab_name_update_precmd() {
    local dir="${PWD##*/}"
    [[ ${#dir} -gt 15 ]] && dir="${dir:0:13}.."
    command zellij action rename-tab "$dir" &>/dev/null
  }
  
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec zellij_tab_name_update_preexec
  add-zsh-hook precmd zellij_tab_name_update_precmd
fi
