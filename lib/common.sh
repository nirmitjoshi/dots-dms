#!/usr/bin/env bash

ensure_regular_user() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    echo "Run this script as your regular user with sudo privileges" >&2
    exit 1
  fi
}

ensure_passwordless_sudo() {
  local user_name="${USER:-$(id -un)}"
  local sudoers_dir="/etc/sudoers.d"
  local sudoers_file="$sudoers_dir/10-wheel-nopasswd"
  local sudoers_line='%wheel ALL=(ALL:ALL) NOPASSWD: ALL'

  if ! getent group wheel >/dev/null 2>&1; then
    echo "Missing wheel group" >&2
    exit 1
  fi

  if id -nG "$user_name" | tr ' ' '\n' | grep -Fxq wheel; then
    echo "User $user_name already belongs to wheel"
  else
    echo "Adding $user_name to wheel"
    sudo usermod -aG wheel "$user_name"
  fi

  if sudo test -f "$sudoers_file" && sudo grep -Fqx "$sudoers_line" "$sudoers_file"; then
    echo "Wheel sudoers entry already allows passwordless sudo"
    return
  fi

  echo "Configuring passwordless sudo for wheel"
  printf '%s\n' "$sudoers_line" | sudo tee "$sudoers_file" >/dev/null
  sudo chmod 0440 "$sudoers_file"
  sudo visudo -cf "$sudoers_file" >/dev/null
}

read_list_file() {
  local path="$1"

  [[ -f "$path" ]] || {
    echo "Missing list file: $path" >&2
    exit 1
  }

  awk '
    /^[[:space:]]*#/ { next }
    /^[[:space:]]*$/ { next }
    { print }
  ' "$path"
}
