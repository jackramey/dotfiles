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

link "$DIR/gitconfig"          "$HOME/.gitconfig"
link "$DIR/gitconfig-aliases"  "$HOME/.gitconfig-aliases"
link "$DIR/gitconfig-personal" "$HOME/.gitconfig-personal"
link "$DIR/gitignore_global"   "$HOME/.gitignore_global"
