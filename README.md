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
./macos/install.sh
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
| `macos/com.user.ssh-add-keychain.plist` | `~/Library/LaunchAgents/com.user.ssh-add-keychain.plist` |

`hammerspoon/` and `iterm2/` are tracked in the repo for reference but have no installer.

### macOS LaunchAgents

`macos/install.sh` symlinks the LaunchAgent and activates it via `launchctl`
(no logout required). The `com.user.ssh-add-keychain` agent runs
`ssh-add --apple-load-keychain` at login, which loads any SSH keys whose
passphrases are saved in the Keychain into `ssh-agent`. It pairs with
`AddKeysToAgent yes` + `UseKeychain yes` in `~/.ssh/config` so the agent is
populated after every reboot — replacing the manual `ssh-add -A`
(now `ssh-add --apple-load-keychain`) step.

To disable it: `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.ssh-add-keychain.plist`
then remove the symlink.
