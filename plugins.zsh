# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_script="${ZPLUGINDIR}/${1}/${1}.plugin.zsh"
  if [[ ! -r "$plugin_script" ]]; then
    print -u2 -r -- "Missing plugin: ${1}. Run: git -C ${(q)ZPLUGINDIR:h} submodule update --init --recursive"
    return 1
  fi
  source "$plugin_script"
}

# Explicitly advance plugin checkouts; commit the updated gitlinks afterward.
zplugin-update() {
  command git -C "${ZPLUGINDIR:h}" submodule update --init --recursive --remote --checkout -- plugins
}

_zplugin_load zsh-autosuggestions
_zplugin_load zsh-history-substring-search
_zplugin_load fast-syntax-highlighting
