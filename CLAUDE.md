# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a suckless tools setup containing five core components: dwm (window manager), st (terminal), dmenu (application launcher), slock (screen locker), and slstatus (status bar). Each component follows the suckless philosophy of simplicity and customization through source code modification.

## Build System

The project uses a centralized build script (`make.sh`) that manages all components:

- **Build all components**: `./make.sh all`
- **Build specific components**: `./make.sh dwm st slstatus`
- **Available components**: dwm, st, slstatus, dmenu, slock

The build script automatically:
1. Removes existing `config.h` files to force regeneration from `config.def.h`
2. Runs `make clean && sudo make install && make clean` for each component
3. Installs binaries to system paths (requires sudo)

Each component has its own Makefile that follows standard suckless conventions:
- `make` - compile the program
- `make install` - install to system (requires sudo)
- `make clean` - remove build artifacts
- `make uninstall` - remove from system

## Architecture & Configuration

### Configuration Pattern
All suckless tools follow the same configuration pattern:
- `config.def.h` - default configuration template
- `config.h` - active configuration (auto-generated from config.def.h)
- Modifications should be made to `config.def.h`, not `config.h`

### Component-Specific Details

**dwm (Window Manager)**
- Custom styling with gaps (`gappx = 4`) and custom colors
- Bottom bar configuration (`topbar = 0`)
- 6 workspaces/tags
- Custom font: "Fira Code:size=10"
- Custom border colors for selected/normal windows

**slstatus (Status Bar)**
- Located in `slstatus/config.h:66-78`
- Current modules: date/time, battery state, CPU frequency, RAM usage, network speeds, volume
- 1-second update interval
- Battery status shows charging symbols (+ - 🔋 🔌)
- Network monitoring on wlan0 interface

**st (Terminal)**
- Uses standard suckless terminal configuration

**dmenu/slock**
- Use default configurations

### Code Structure

**slstatus Components**
The status bar uses a modular component system:
- Components in `slstatus/components/` directory
- Each component provides specific system information
- Battery component (`slstatus/components/battery.c`) supports Linux, OpenBSD, and FreeBSD
- Platform-specific implementations using conditional compilation

## Development Workflow

1. **Making Configuration Changes**:
   - Edit `config.def.h` files in respective component directories
   - Use `./make.sh component_name` to rebuild and install
   - The build script automatically handles config.h regeneration

2. **Component Development**:
   - Each component is self-contained in its directory
   - Standard suckless Makefile conventions apply
   - Dependencies defined in individual Makefiles

3. **Status Bar Customization**:
   - Modify `slstatus/config.h` args array to change displayed information
   - Add/remove/reorder status components
   - Customize update intervals and formatting strings

## Git Integration

The repository tracks:
- All configuration files (`config.h` and `config.def.h`)
- Source modifications to components like `slstatus/components/battery.c`
- The centralized build script

Excluded: `**/.git` directories from individual suckless repositories.