#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
root_dir="$(cd -- "$script_dir/.." && pwd -P)"

source "$root_dir/lib/common.sh"

echo "Launching interactive dankinstall"
curl -fsSL https://install.danklinux.com | sh
