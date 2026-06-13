# NixOS flake — `/etc/nixos`

## Architecture

- **Entrypoint:** `flake.nix`. Uses `flake-parts` + `import-tree` — all `.nix` files under `modules/` are auto-discovered, no manual imports.
- **Hosts:** single host `my-machine` → outputs `nixosConfigurations.nixOS`.
- **Module pattern:** each file under `modules/features/` or `modules/hosts/` defines `flake.nixosModules.<name>` and/or `flake.homeModules.<name>` as flake outputs.
- **Color/dots system:** centralized in `modules/hosts/my-machine/dots/userDots.nix` → accessible as `self.dots.*` across modules. Changes require a rebuild.

## Commands

| Action | Command (or alias) |
|---|---|
| Rebuild system | `sudo nixos-rebuild switch --flake /etc/nixos` / `nxr` |
| Update flake lock | `nix flake update --flake /etc/nixos` / `update-flake` |
| GC old generations | `sudo nix-collect-garbage` / `nxcg` |
| Inspect flake outputs | `nix flake show /etc/nixos` |
| Run animated fastfetch | `fastfetch-animated` / `ff` |

Aliases are defined (bash + fish) in `modules/hosts/my-machine/programs.nix`.

## Edit-time gotchas

- **Ownership:** `/etc/nixos` is root-owned on this machine. On a fresh install, run `sudo chown -R $USER:$USER /etc/nixos` before adding files.
- **Symlinked configs:** niri config (`dots/files/niri-config.kdl`) and driftwm config use `mkOutOfStoreSymlink` — edit the file in place without rebuilding.
- **Color/dots change:** updating `userDots.nix` always requires a rebuild; the symlink bypass does not apply.

## Key inputs (non-standard)

| Input | Source | Purpose |
|---|---|---|
| `apple-fonts` | `github:Lyndeno/apple-fonts.nix` | SF Pro / SF Mono / NY Nerd fonts |
| `pebble-icons` | local: `/home/fleugle/my-flakes/Pebble-Icon-Theme-flake` | GTK icon theme |
| `zen-browser-flake` | `github:0xc000022070/zen-browser-flake` | Custom Firefox-based browser |
| `lazyvim-flake` | `github:pfassina/lazyvim-nix` | LazyVim Neovim distro |
| `wrapper-modules` | `github:BirdeeHub/nix-wrapper-modules` | Nix wrapper utilities |
| `stylix` | `github:nix-community/stylix` | System theming |
| `home-manager` | `github:nix-community/home-manager` | User env management |

## Conventions & quirks

- **Shell aliases** (`nxr`, `update-flake`, `nxcg`, `ff`, `opn`) are defined identically in both `programs.fish` and `programs.bash` in `programs.nix`.
- **stateVersion** = `"25.11"` — don't bump unless intentional.
- **Ollama** runs with `loadModels` + `syncModels = true`; swap `pkgs.ollama` → `pkgs.ollama-cuda` for NVIDIA GPU.
- **VirtualBox guest** enabled (`virtualisation.virtualbox.guest.enable = true`).
- **GNOME + niri** both enabled; DriftWM is commented out in `config.nix`.
- **Home-manager:** `useGlobalPkgs = true`, `useUserPackages = true`, backups get `.backup` extension.
- **User:** `fleugle` only, shell is fish, `nix.settings.experimental-features = ["nix-command" "flakes"]`.
- **fastfetch-animated** is a custom Python script in `modules/features/fastfetch-animated.py`; colors are injected at build time via `builtins.replaceStrings`.
- **`programs.nix`** is split into three flake outputs: `nixosModules.systemPrograms`, `homeModules.userPrograms` (shared), `homeModules.fleuglePrograms` (user-specific).
