# dots

Post archinstall setup.

Run as your regular user:

```bash
./run.sh
```

Project layout:

- `dotfiles/`: your configs and wallpapers
- `packages/`: package manifests grouped by source
- `scripts/`: executable setup phases in run order
- `lib/`: shared shell helpers

Execution flow:

1. install pacman and AUR packages
2. install Dank Linux
3. stow custom dotfiles
4. patch DMS-owned configs to load local too
5. apply user setup such as screenshots dir and default shell
