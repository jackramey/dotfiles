#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  $dst already linked"
    return 0
  fi
  if [ -L "$dst" ]; then
    echo "  replacing existing symlink $dst"
    rm "$dst"
  elif [ -e "$dst" ]; then
    local backup="${dst}.backup"
    if [ -e "$backup" ] || [ -L "$backup" ]; then
      backup="${dst}.backup_$(date +%Y_%m_%d_%H%M%S)"
    fi
    echo "  backing up $dst to $backup"
    mv "$dst" "$backup"
  fi
  ln -s "$src" "$dst"
  echo "  linked $dst -> $src"
}

# LaunchAgent: load SSH keys whose passphrases are stored in the Keychain at
# login. Pairs with `AddKeysToAgent yes` + `UseKeychain yes` in ~/.ssh/config so
# the agent is populated after every reboot without a manual `ssh-add`.
PLIST="com.user.ssh-add-keychain.plist"
DST="$HOME/Library/LaunchAgents/$PLIST"

link "$DIR/$PLIST" "$DST"

# Activate now (idempotent). Newer macOS prefers bootstrap; fall back to load.
if launchctl bootstrap "gui/$(id -u)" "$DST" 2>/dev/null; then
  echo "  bootstrapped $PLIST"
elif launchctl load "$DST" 2>/dev/null; then
  echo "  loaded $PLIST"
else
  echo "  $PLIST already active (or will load at next login)"
fi
