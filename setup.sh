#!/bin/sh

# Full setup script for suckless desktop on a fresh Arch Linux installation
# Usage: git clone <repo> ~/suckless_setup && cd ~/suckless_setup && ./setup.sh

set -e

echo "============================================"
echo "  Suckless Desktop Setup for Arch Linux"
echo "============================================"

# Step 1: Install all dependencies
echo -e "\n[1/5] Installing dependencies..."
./install-deps.sh

# Step 2: Build and install all suckless components
echo -e "\n[2/5] Building suckless tools (dwm, slstatus, dmenu, slock)..."
./make.sh all

# Step 3: Enable services
echo -e "\n[3/5] Enabling system services..."
sudo systemctl enable --now bluetooth 2>/dev/null || echo "    bluetooth service not available, skipping"
sudo systemctl enable --now iwd 2>/dev/null || echo "    iwd service not available, skipping"

# Step 4: Install fonts
echo -e "\n[4/5] Installing fonts..."
sudo pacman -S --needed ttf-fira-code || echo "    Font install skipped"

# Step 5: Summary
echo -e "\n[5/5] Setup complete!"
echo ""
echo "============================================"
echo "  What was installed:"
echo "    - dwm (window manager)"
echo "    - slstatus (status bar)"
echo "    - dmenu (app launcher)"
echo "    - slock (screen locker)"
echo "    - Configs: .xinitrc, .vimrc, dunstrc"
echo "    - Scripts: volcatctl, powermenu, wifimenu,"
echo "              bt, scrot-s, resource_usage"
echo ""
echo "  To start the desktop:"
echo "    startx"
echo ""
echo "  To auto-start on login, add to ~/.bash_profile:"
echo "    if [[ -z \"\$DISPLAY\" ]] && [[ \"\$XDG_VTNR\" -eq 1 ]]; then"
echo "        exec startx"
echo "    fi"
echo ""
echo "  Notes:"
echo "    - Set a wallpaper at ~/fehbg"
echo "    - Mod key is Alt"
echo "    - Terminal: kitty"
echo "============================================"
