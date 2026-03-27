#!/bin/sh

# Install dependencies for suckless setup (Arch Linux)

echo "==> Installing build dependencies..."
sudo pacman -S --needed base-devel libx11 libxft libxinerama fontconfig \
    libxext libxrandr alsa-lib xorg-server xorg-xinit

echo -e "\n==> Installing core tools..."
sudo pacman -S --needed kitty dunst picom feh scrot brightnessctl xclip \
    wireplumber libnotify bc

echo -e "\n==> Installing networking..."
sudo pacman -S --needed iwd

echo -e "\n==> Installing audio & bluetooth..."
sudo pacman -S --needed easyeffects pavucontrol bluez bluez-utils blueman

echo -e "\n==> Installing optional applications..."
sudo pacman -S --needed firefox code

echo -e "\n==> All dependencies installed."
