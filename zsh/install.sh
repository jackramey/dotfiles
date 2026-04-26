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

# Only ~/.zshrc is symlinked. zshrc itself sets ZDOTDIR to this directory
# so common.zsh, gradle.zsh, p10k.zsh, local/, etc. load from the repo.
link "$DIR/zshrc" "$HOME/.zshrc"
