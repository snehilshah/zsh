#!/usr/bin/env bash
# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# the path for .zshrc is set in zshenv in the folder /etc/zshenv
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node fnm zsh-autosuggestions you-should-use golang zsh-syntax-highlighting zsh-history-substring-search) 

source $ZSH/oh-my-zsh.sh

# Custom command execution time tracking
preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))
    
    # Convert milliseconds to human readable format
    if [ $elapsed -ge 60000 ]; then
      # 1 minute or more - show in red
      minutes=$((elapsed / 60000))
      seconds=$(((elapsed % 60000) / 1000))
      if [ $seconds -gt 0 ]; then
        export RPS1="%F{red}${minutes}m ${seconds}s%f"
      else
        export RPS1="%F{red}${minutes}m%f"
      fi
    elif [ $elapsed -ge 1000 ]; then
      # 1 second to 60 seconds - show in yellow
      seconds=$((elapsed / 1000))
      export RPS1="%F{yellow}${seconds}s%f"
    elif [ $elapsed -ge 100 ]; then
      # 100ms to 1 second - show in green
      export RPS1="%F{green}${elapsed}ms%f"
    else
      # Less than 100ms - show in dim gray
      export RPS1="%F{242}${elapsed}ms%f"
    fi
    
    unset timer
  else
    export RPS1=""
  fi
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_IN.UTF-8
export LANGUAGE=en_IN.UTF-8
export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"
export TERM=xterm-256color
export PAGER=moor

path+=("/usr/local/go/bin")
path+=("$HOME/.local/kitty.app/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/go/bin")
path+=("/home/linuxbrew/.linuxbrew/opt/postgresql@17/bin")
export PATH

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

# fnm
FNM_PATH="/home/snehilshah/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/snehilshah/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi


# pnpm
export PNPM_HOME="/home/snehilshah/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
