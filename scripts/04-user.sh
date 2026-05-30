#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/Pictures/Screenshots"

zsh_path="$(command -v zsh)"
if [[ -z "$zsh_path" ]]; then
  echo "Zsh not found" >&2
  exit 1
fi

user_name="${USER:-$(id -un)}"

echo "Setting default shell to zsh for user $user_name"
chsh -s "$zsh_path" "$user_name"

echo "User setup completed"
