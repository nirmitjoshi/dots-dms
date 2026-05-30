#!/usr/bin/env bash
set -euo pipefail

ensure_line() {
  local file_path="$1"
  local line="$2"

  [[ -f "$file_path" ]] || {
    echo "Missing config file: $file_path" >&2
    exit 1
  }

  if grep -Fqx "$line" "$file_path"; then
    return
  fi

  printf '\n%s\n' "$line" >>"$file_path"
}

apply_niri_override() {
  local config_path="$HOME/.config/niri/config.kdl"
  local include_line='include "local.kdl"'

  echo "Linking local niri config into DMS config"
  ensure_line "$config_path" "$include_line"
}

apply_niri_override
