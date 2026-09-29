# ZSH Configuration

Personal standalone Zsh configuration with Oh My Posh and Homebrew-managed plugins. Oh My Zsh is not required.

## Setup

### Prerequisites

- Zsh and Git
- [oh-my-posh](https://ohmyposh.dev/) for prompt theming
- [Homebrew](https://brew.sh/) (Linuxbrew)

### Clone Repository

```bash
git clone https://github.com/snehilshah/zsh.git ~/.config/zsh
```

Install the three Zsh plugins with Homebrew:

```bash
brew install zsh-autosuggestions zsh-history-substring-search zsh-fast-syntax-highlighting
```

### Locate Shell Configuration

Ensure your shell knows where to find the config. Set `ZDOTDIR` before starting Zsh (or in your distribution's global `zshenv`):

```bash
export ZDOTDIR="$HOME/.config/zsh"
```

## Structure

```
zsh/
├── .zshrc                 # Main zsh configuration
├── .zshenv                # Shell environment setup
├── aliases.zsh            # Custom aliases
├── git.zsh                # Git-related customizations
├── fzf.zsh                # Fuzzy-finder integration
├── kubernetes.zsh         # Kubernetes helpers
├── keyboards.zsh          # Key bindings and paste settings
└── plugins.zsh            # Loads Homebrew-installed plugins
```

## Plugins (Homebrew)

| Plugin | Description |
|--------|-------------|
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like autosuggestions |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting for commands |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | Fish-like history search |

`plugins.zsh` loads the Homebrew installations at shell startup. Homebrew manages installation and updates:

```bash
brew upgrade zsh-autosuggestions zsh-history-substring-search zsh-fast-syntax-highlighting
```

Start a new shell after an update.

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
