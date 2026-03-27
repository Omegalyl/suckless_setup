# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a suckless tools setup containing four core components: dwm (window manager), dmenu (application launcher), slock (screen locker), and slstatus (status bar). Each component follows the suckless philosophy of simplicity and customization through source code modification.

## Build System

The project uses a centralized build script (`make.sh`) that manages all components:

- **Build all + install configs**: `./make.sh all`
- **Build specific components**: `./make.sh dwm slstatus`
- **Install dotfiles and scripts only**: `./make.sh configs`
- **Install dependencies**: `./install-deps.sh`
- **Available components**: dwm, slstatus, dmenu, slock

The build script:
1. Runs `make clean && sudo make install && make clean` for each component
2. Installs binaries to system paths (requires sudo)
3. With `all` or `configs`: copies dotfiles to `~/` and scripts to `~/bin/`

## Architecture & Configuration

### Configuration Pattern
- `config.h` is the **single source of truth** — edit it directly
- There is no `config.def.h` (removed)
- Rebuild with `./make.sh component_name` after changes

### Component-Specific Details

**dwm (Window Manager)**
- Custom styling with gaps (`gappx = 4`) and custom colors
- Bottom bar configuration (`topbar = 0`)
- 6 workspaces/tags
- Custom font: "Fira Code:size=10"
- Terminal: kitty, Mod key: Alt
- Volume control via wpctl (PipeWire)
- Keybinds for: brightness, slock, screenshots, firefox, vscode, powermenu, wifimenu

**slstatus (Status Bar)**
- Located in `slstatus/config.h`
- Modules: uptime, disk, cpu (% + freq + temp), ram, battery (% + remaining), network (averaged), volume, datetime
- 1-second update interval
- Network speed averaged over 3s via `scripts/netspeed`

**dmenu/slock**
- Use default configurations

### Scripts (`scripts/`)
- **netspeed** - Averaged network speed for slstatus
- **powermenu** - dmenu power menu (lock/suspend/reboot/shutdown)
- **wifimenu** - dmenu wifi selector using iwd
- **bt** - Bluetooth device management
- **scrot-s** - Screenshot with selection
- **resource_usage** - System resource monitoring

### Dotfiles (`config/`)
- `.xinitrc` - X startup (picom, feh, slstatus, dunst, apps)
- `.vimrc` - Vim configuration
- `dunstrc` - Dunst notification config

## Development Workflow

1. **Making Configuration Changes**:
   - Edit `config.h` in the respective component directory
   - Run `./make.sh component_name` to rebuild and install

2. **Adding Scripts**:
   - Add to `scripts/` directory
   - Run `./make.sh configs` to install to `~/bin/`

3. **Dotfile Changes**:
   - Edit files in `config/`
   - Run `./make.sh configs` to deploy

## Git Integration

The repository tracks:
- All `config.h` files (single source of truth)
- Scripts, dotfiles, and build tooling
- Source modifications to components
