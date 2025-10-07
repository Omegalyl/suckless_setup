# Dependencies

This document lists the external packages required for the complete suckless setup.

## Required Packages

### Core System
- **kitty** - Modern, GPU-accelerated terminal emulator (replaces st)
- **dunst** - Lightweight notification daemon
- **xcompmgr** - X11 compositor for transparency and effects

### Display & Media
- **feh** - Wallpaper setter and image viewer
- **scrot** - Screenshot utility

### Audio & System Control
- **easyeffects** - Audio effects and enhancement
- **pavucontrol** - PulseAudio volume control GUI
- **bluez** - Bluetooth stack (includes bluetoothctl)


### Applications (Optional)
- **firefox** - Web browser
- **code** - Visual Studio Code editor

## Installation Commands

### Arch Linux / Arch-based distros:
```bash
# Core system packages
sudo pacman -S kitty dunst xcompmgr feh scrot

# Audio & Bluetooth
sudo pacman -S easyeffects pavucontrol bluez bluez-utils

# Development tools
sudo pacman -S base-devel python python-pip gcc vim

# Optional applications
sudo pacman -S firefox code
```

## Configuration Files

- **kitty**: `~/.config/kitty/kitty.conf` (themes in `~/.config/kitty/themes/`)
- **dunst**: `config/dunstrc` → copy to `~/.config/dunst/dunstrc`
- **vim**: `config/.vimrc` → copy to `~/.vimrc`
- **xinitrc**: `config/.xinitrc` → copy to `~/.xinitrc`

## Scripts

- **bt**: `scripts/bt` - Bluetooth device management script
- **resource_usage**: `scripts/resource_usage` - System resource monitoring
- **scrot-s**: `scripts/scrot-s` - Screenshot with selection

## Integration with dwm

The `dwm/config.def.h` has been updated to use `kitty` as the default terminal:
```c
static const char *termcmd[] = { "kitty", NULL };
```

To use these tools with dwm, ensure they're installed before building and using the window manager setup.