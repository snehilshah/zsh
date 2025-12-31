# ZSH Configuration

Personal zsh configuration with oh-my-zsh and custom plugins.

## Setup

### Prerequisites

- [oh-my-zsh](https://ohmyz.sh/) installed at `~/.config/.oh-my-zsh`
- [oh-my-posh](https://ohmyposh.dev/) for prompt theming
- [Homebrew](https://brew.sh/) (Linuxbrew)

### Clone Repository

```bash
git clone --recursive https://github.com/YOUR_USERNAME/zsh.git ~/.config/zsh
```

Or if already cloned without submodules:

```bash
git submodule update --init --recursive
```

### Symlink (if needed)

Ensure your shell knows where to find the config. Add to `/etc/zshenv` or set `ZDOTDIR`:

```bash
export ZDOTDIR="$HOME/.config/zsh"
```

## Structure

```
zsh/
├── .zshrc                 # Main zsh configuration
├── .zsh_history           # Command history
├── custom/
│   ├── aliases.zsh        # Custom aliases
│   ├── git.zsh            # Git-related customizations
│   ├── completions/       # Custom completions
│   │   └── _zellij
│   └── plugins/           # oh-my-zsh plugins (submodules)
│       ├── zsh-autosuggestions
│       ├── zsh-syntax-highlighting
│       └── zsh-history-substring-search
```

## Plugins (Submodules)

| Plugin | Description |
|--------|-------------|
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like autosuggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax highlighting for commands |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | Fish-like history search |

### Update Plugins

```bash
git submodule update --remote
```

## Key Bindings

| Binding | Action |
|---------|--------|
| `Alt + Enter` | Accept autosuggestion |
| `Alt + f` | Forward word |
| `Ctrl + a` | Beginning of line |
| `Ctrl + e` | End of line |
| `Up/Down` | History substring search |

## Tools & Aliases

This config assumes the following tools are installed:

| Alias | Tool | Description |
|-------|------|-------------|
| `ls` | [eza](https://github.com/eza-community/eza) | Modern ls replacement |
| `cat` | [bat](https://github.com/sharkdp/bat) | Cat with syntax highlighting |
| `du` | [dust](https://github.com/bootandy/dust) | Intuitive disk usage |
| `find` | [fd](https://github.com/sharkdp/fd) | Fast file finder |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter cd command |
| `explorer` | [yazi](https://github.com/sxyazi/yazi) | Terminal file manager |
| `vi`, `nv` | [neovim](https://neovim.io/) | Text editor |
