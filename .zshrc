#!/usr/bin/env zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# the path for .zshrc is set in zshenv in the folder /etc/zshenv
export ZSH="$HOME/.config/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':omz:update' mode reminder # just remind me to update when it's time
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit

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

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl zsh-autosuggestions golang zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_IN.UTF-8
export LANGUAGE=en_IN.UTF-8
export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"
export TERM=xterm-256color

path+=("/usr/local/go/bin")
path+=("$HOME/.local/kitty.app/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/go/bin")
path+=("/home/linuxbrew/.linuxbrew/opt/postgresql@17/bin")

alias ls="eza"
alias cat="bat"
alias du="dust"
alias explorer="yazi"

# ZSH Paths
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.config/zsh/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Paths
path+=('/usr/local/go/bin')
path+=('/home/srshah/go/bin')
path+=('/home/srshah/.local/bin')
path+=('/home/srshah/go/bun')
path+=('/home/srshah/.cargo/bin')

export PATH

# zoxide
eval "$(zoxide init --cmd cd zsh)"

export PATH="/home/linuxbrew/.linuxbrew/opt/clang-format/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"

bindkey '^[^M' autosuggest-accept
bindkey '^[f' forward-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/srshah/downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/srshah/downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/srshah/downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/srshah/downloads/google-cloud-sdk/completion.zsh.inc'; fi

export GPG_TTY=$(tty)
. "/home/srshah/.deno/env"

export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@21/bin:$PATH"

function current_dir() {
  local current_dir=$PWD
  if [[ $current_dir == $HOME ]]; then
    current_dir="~"
  else
    current_dir=${current_dir##*/}
  fi

  echo $current_dir
}

function change_tab_title() {
  local title=$1
  command nohup zellij action rename-tab $title >/dev/null 2>&1
}

function set_tab_to_working_dir() {
  local result=$?
  local title=$(current_dir)
  change_tab_title $title
}

function set_tab_to_command_line() {
  local cmdline=$1
  local first_word=${cmdline%% *}
  change_tab_title $first_word
}

if [[ -n $ZELLIJ ]]; then
  add-zsh-hook precmd set_tab_to_working_dir
  add-zsh-hook preexec set_tab_to_command_line
fi

# eval "$(zellij setup --generate-auto-start zsh)"
source <(fzf --zsh)

# Load kubectl fzf integrations (simple aliases only, no completions)
source ~/.config/zsh/kubectl-fzf.zsh
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
