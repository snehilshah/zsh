# =========================================================
# fzf
# =========================================================

# Setup modern fzf shell integration (completions and key-bindings)
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'  # strip-cwd-prefix removes the leading ./ from results

# Ctrl-T uses fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# UI (Style C: Ultra-Compact & High-Density)
export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border=none
  --info=inline
  --prompt="   "
  --pointer="❯"
  --marker="✓"
  --scrollbar="│"
  --preview-window=right:55%:border-left:wrap
  --color="bg+:-1,fg+:white,hl:blue,hl+:cyan"
  --color="info:magenta,prompt:cyan,pointer:cyan,marker:green,spinner:red"
'

export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# Ctrl+F: file picker excluding hidden files
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"  # LBUFFER is the text left of the cursor
  zle reset-prompt
}
zle -N _fzf_file_no_hidden
bindkey '^f' _fzf_file_no_hidden
