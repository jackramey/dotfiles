dotfiles
========

My own personal collection of dot files that I've poached and personalized from friends and online sources.

## Install

Configs are installed as symlinks from `$HOME` (and other standard locations) back into this repo, so edits to tracked files take effect immediately.

If a real (non-symlink) file is already at a destination, it's moved to `<filename>.backup` before linking. If `<filename>.backup` already exists, the previous file is moved to `<filename>.backup_YYYY_MM_DD_HHMMSS` so the original is never overwritten.

### Install everything (interactive)

From the repo root:

```sh
./install.sh
```

You'll be prompted `[y/N]` for each subdirectory that ships an `install.sh`. Decline the ones you don't want.

### Install one subdir

Each subdir owns its own installer. Run it directly:

```sh
./vim/install.sh
./zsh/install.sh
./git/install.sh
./ghostty/install.sh
./karabiner/install.sh
```

### What gets installed where

| Subdir | Destination |
| --- | --- |
| `vim/vimrc` | `~/.vimrc` |
| `zsh/zshrc` | `~/.zshrc` (other zsh files stay in the repo and are sourced via `$ZDOTDIR`) |
| `git/gitconfig` | `~/.gitconfig` |
| `git/gitconfig-aliases` | `~/.gitconfig-aliases` |
| `git/gitconfig-personal` | `~/.gitconfig-personal` |
| `git/gitignore_global` | `~/.gitignore_global` |
| `ghostty/config.ghostty` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` |

`hammerspoon/` and `iterm2/` are tracked in the repo for reference but have no installer.
