# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi

  # Find the main script to source dynamically
  local script
  for script in "${plugin_path}/${2}.plugin.zsh" \
                "${plugin_path}/${2}.zsh" \
                "${plugin_path}/${2}.zsh-theme" \
                "${plugin_path}/${2}.sh"; do
    if [[ -f "$script" ]]; then
      source "$script"
      return 0
    fi
  done
  
  echo "ERROR: Could not find main script for ${2}" >&2
  return 1
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load zdharma-continuum fast-syntax-highlighting
