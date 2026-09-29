#!/usr/bin/env zsh

# ---------- Interactive Environment & PATH ----------
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER="bat -l man -p"
[[ -t 0 ]] && export GPG_TTY=$(tty)

path+=("$HOME/go/bin")
export PATH

# Personal application settings and secrets (not tracked by Git)
[[ -r "$ZDOTDIR/env.local.zsh" ]] && source "$ZDOTDIR/env.local.zsh"

# ---------- Shell Options & Completions ----------
bindkey -e               # use emacs-style editing even when EDITOR is nvim
setopt AUTO_CD           # cd by typing directory name
setopt NO_BEEP           # quiet shell
setopt NUMERIC_GLOB_SORT # sort filenames numerically
ulimit -S -n 2048

# Completion styling and behavior
setopt COMPLETE_IN_WORD # allow completion from within a word
setopt ALWAYS_TO_END    # move cursor to end of word after completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive matches
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Load native completion system
autoload -Uz compinit
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
compinit -d "$ZSH_COMPDUMP"

# ---------- History Setup ----------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

# ---------- Sourced Helper Scripts & Aliases ----------
source "$ZDOTDIR/git.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/kubernetes.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/keyboards.zsh"

# Suffix alias utility
autoload zmv

# ---------- Integrative Initializations ----------
# zoxide
eval "$(zoxide init --cmd cd zsh)"
# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
_omp_executable="oh-my-posh"

# ---------- Helper Functions ----------
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
