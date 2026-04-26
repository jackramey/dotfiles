#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

prompt_yn() {
  local prompt="$1"
  local reply
  read -r -p "$prompt [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

run_subdir_install() {
  local subdir="$1"
  local script="$REPO_DIR/$subdir/install.sh"
  [ -x "$script" ] || return 0

  echo
  if prompt_yn "Install $subdir config?"; then
    echo "--- installing $subdir ---"
    "$script"
  else
    echo "--- skipping $subdir ---"
  fi
}

for dir in "$REPO_DIR"/*/; do
  subdir="$(basename "$dir")"
  run_subdir_install "$subdir"
done

echo
echo "Done."
