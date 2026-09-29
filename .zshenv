typeset -U path PATH

# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Prevent Ubuntu's global /etc/zsh/zshrc from running compinit prematurely
export skip_global_compinit=1

# ---------- Base PATH ----------
export PATH="$HOME/.local/bin:$PATH"
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
