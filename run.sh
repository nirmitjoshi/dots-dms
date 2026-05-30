#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
root_dir="$script_dir"

source "$root_dir/lib/common.sh"

ensure_regular_user
ensure_passwordless_sudo

echo "Running setup"
"$root_dir/scripts/00-packages.sh"
"$root_dir/scripts/01-dank.sh"
"$root_dir/scripts/02-dotfiles.sh"
"$root_dir/scripts/03-overrides.sh"
"$root_dir/scripts/04-user.sh"

read -r -p "Reboot now to pick up all changes? [y/N] " reboot_now
if [[ "$reboot_now" =~ ^[Yy]$ ]]; then
  sudo reboot
fi
