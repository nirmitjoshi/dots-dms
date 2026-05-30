#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
root_dir="$(cd -- "$script_dir/.." && pwd -P)"

dot_dir="$root_dir/dotfiles"
zshrc_src="$dot_dir/.zshrc"
dot_config="$dot_dir/.config"
dot_local="$dot_dir/.local"
user_unit_src="$dot_dir/.config/systemd/user/kdeconnectd.service"
user_unit_dst="$HOME/.config/systemd/user/kdeconnectd.service"
niri_wants_dir="$HOME/.config/systemd/user/niri.service.wants"

[[ -d "$dot_config" ]] || { echo "Missing dotfiles dir: $dot_config" >&2; exit 1; }
[[ -d "$dot_local" ]] || { echo "Missing dotfiles dir: $dot_local" >&2; exit 1; }
[[ -f "$zshrc_src" ]] || { echo "Missing file: $zshrc_src" >&2; exit 1; }
[[ -f "$user_unit_src" ]] || { echo "Missing file: $user_unit_src" >&2; exit 1; }

echo "Stowing dotfiles into $HOME"
mkdir -p "$HOME/.config" "$HOME/.local"

stow --dir="$dot_config" --target="$HOME/.config" --ignore='^systemd($|/)' .

wallpaper_src="$dot_local/share/wallpapers"
wallpaper_dst="$HOME/.local/share/wallpapers"
mkdir -p "$HOME/.local/share"
if [[ -L "$wallpaper_dst" ]]; then
  ln -sfn "$wallpaper_src" "$wallpaper_dst"
elif [[ ! -e "$wallpaper_dst" ]]; then
  ln -s "$wallpaper_src" "$wallpaper_dst"
else
  echo "Wallpaper destination already exists and is not a symlink: $wallpaper_dst" >&2
  exit 1
fi

cp "$zshrc_src" "$HOME/.zshrc"

mkdir -p "$HOME/.config/systemd/user" "$niri_wants_dir"
ln -sfn "$user_unit_src" "$user_unit_dst"
ln -sfn /usr/lib/systemd/user/dms.service "$niri_wants_dir/dms.service"
ln -sfn "$user_unit_dst" "$niri_wants_dir/kdeconnectd.service"

echo "Dotfiles setup completed"
