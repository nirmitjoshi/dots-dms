#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
root_dir="$(cd -- "$script_dir/.." && pwd -P)"

source "$root_dir/lib/common.sh"

pacman_list="$root_dir/packages/pacman.txt"
aur_list="$root_dir/packages/aur.txt"

mapfile -t pacman_packages < <(read_list_file "$pacman_list")
mapfile -t aur_packages < <(read_list_file "$aur_list")

echo "Syncing package databases"
sudo pacman -Syu --needed --noconfirm

if [[ "${#pacman_packages[@]}" -gt 0 ]]; then
  echo "Installing pacman packages"
  sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"
fi

if command -v rustup >/dev/null 2>&1; then
  rustup default stable
fi

if ! command -v paru >/dev/null 2>&1; then
  echo "Installing paru"
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT
  git clone https://aur.archlinux.org/paru.git "$tmpdir/paru"
  (
    cd "$tmpdir/paru"
    makepkg -si --noconfirm
  )
fi

if [[ "${#aur_packages[@]}" -gt 0 ]]; then
  echo "Installing AUR packages"
  paru -S --needed --noconfirm "${aur_packages[@]}"
fi

echo "Enabling tailscaled service"
sudo systemctl enable tailscaled

echo "Allowing KDE Connect through ufw"
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp
