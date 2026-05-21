#!/usr/bin/env zsh

# ---------- Homebrew Setup ----------
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ---------- Shell Options & Completions ----------
setopt AUTO_CD               # cd by typing directory name
setopt NO_BEEP               # quiet shell
setopt NUMERIC_GLOB_SORT     # sort filenames numerically
ulimit -S -n 2048

# Completion styling and behavior
setopt COMPLETE_IN_WORD      # allow completion from within a word
setopt ALWAYS_TO_END         # move cursor to end of word after completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive matches

# Load native completion system
autoload -Uz compinit
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
compinit -d "$ZSH_COMPDUMP"

# ---------- Plugins (Direct Loading) ----------
# We source your existing plugin clones directly. This is extremely fast!
# ---------- Plugins (Dynamic Loading via plugins.zsh) ----------
source "$ZDOTDIR/plugins.zsh"

# ---------- Word Style & Key Bindings ----------
# Use Bash-style word boundaries (so Alt+Backspace and Alt-navigation delete/move by segments)
autoload -U select-word-style
select-word-style bash

# Explicitly bind Alt+Backspace to delete a word segment
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word

bindkey '^[^M' autosuggest-accept
bindkey '^[f' forward-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Up/Down arrow keys for history substring search with terminfo guards & fallbacks
if [[ -n "$terminfo[kcuu1]" ]]; then
  bindkey "$terminfo[kcuu1]" history-substring-search-up
else
  bindkey '^[[A' history-substring-search-up
fi

if [[ -n "$terminfo[kcud1]" ]]; then
  bindkey "$terminfo[kcud1]" history-substring-search-down
else
  bindkey '^[[B' history-substring-search-down
fi

# Edit current command line in NVIM (Ctrl+X Ctrl+E)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Insert git commit template (Ctrl+X, G, C)
bindkey -s '^Xgc' 'git commit -m ""\C-b'

# ---------- History Setup ----------
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

# ---------- Custom Paths & Environment ----------
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"

path+=(
  '/usr/local/go/bin'
  '/home/snehilshah/go/bin'
  '/home/snehilshah/.local/bin'
  '/home/snehilshah/.bun/bin'
  '/home/linuxbrew/.linuxbrew/opt/node@24/bin'
)
export PATH

export GIT_CONFIG_SYSTEM="/home/snehilshah/.config/git/gitconfig"

# ---------- Sourced Helper Scripts & Aliases ----------
source "$ZDOTDIR/git.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/kubernetes.zsh"

# Suffix alias utility
autoload zmv

# ---------- Integrative Initializations ----------
# zoxide
eval "$(zoxide init --cmd cd zsh)"
# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# ---------- Helper Functions ----------
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

sourceenv() {
  local envfile="${1:-.env}"
  if [[ ! -f "$envfile" ]]; then
    echo "sourceenv: file not found: $envfile" >&2
    return 1
  fi
  set -a
  source "$envfile"
  set +a
}
