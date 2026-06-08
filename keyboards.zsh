# ---------- Word Style & Key Bindings ----------
# Treat '/' as a word separator by excluding it from WORDCHARS
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Explicitly bind Alt+Backspace to delete a complete word
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

# ---------- Robust Fixes ----------

# 1. Ctrl + Left/Right Arrow Word Navigation
# Covers different terminal escape sequences (xterm, rxvt, tmux, kitty, alacritty, etc.)
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[OD" backward-char
bindkey "^[OC" forward-char
bindkey "^[[5D" backward-word
bindkey "^[[5C" forward-word

# 2. Multi-line Backspace Issue
# Explicitly bind Backspace keys (^? and ^H) to backward-delete-char
# in both emacs (default) and vi insert modes to ensure they delete newlines.
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^H" backward-delete-char

