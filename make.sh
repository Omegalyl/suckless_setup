#!/usr/bin/env bash

# List of applications to build and install
apps=("dwm" "slstatus" "dmenu" "slock")

# Function to show usage
show_usage() {
    echo "Usage: $0 [all | app_name...]"
    echo "Build and install suckless tools."
    echo
    echo "Options:"
    echo "  all         Build all applications and install configs"
    echo "  configs     Install dotfiles and scripts only"
    echo "  app_name    Build specific application(s)"
    echo
    echo "Available applications:"
    printf "  %s\n" "${apps[@]}"
    echo
    echo "Examples:"
    echo "  $0 all          # Build all apps and install configs"
    echo "  $0 configs      # Install dotfiles and scripts only"
    echo "  $0 dwm st       # Build only dwm and st"
    echo
}

# Function to validate app names
validate_apps() {
    local app
    for app in "$@"; do
        if [[ "$app" != "all" ]] && [[ "$app" != "configs" ]] && [[ ! " ${apps[@]} " =~ " ${app} " ]]; then
            handle_error "Invalid application: $app"
        fi
    done
}

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Function to install dotfiles and scripts
install_configs() {
    echo -e "\n\n==> Installing dotfiles..."

    # Dotfiles: config/.filename -> ~/
    for dotfile in config/.*; do
        [[ "$(basename "$dotfile")" == "." || "$(basename "$dotfile")" == ".." ]] && continue
        cp -v "$dotfile" ~/
    done

    # Regular config files: config/filename -> ~/.config/filename
    for conf in config/*; do
        [[ -f "$conf" ]] || continue
        mkdir -p ~/.config
        cp -v "$conf" ~/.config/
    done

    echo "    Dotfiles installed."

    # Scripts -> ~/bin/
    echo -e "\n==> Installing scripts..."
    mkdir -p ~/bin
    for script in scripts/*; do
        [[ -f "$script" ]] || continue
        cp -v "$script" ~/bin/
        chmod +x ~/bin/"$(basename "$script")"
    done
    echo "    Scripts installed to ~/bin/"
}

# Function to build and install an application
build_install_app() {
    local app="$1"
    echo -e "\n\n==> Building and installing $app..."
    
    if [[ ! -d "$app" ]]; then
        handle_error "Directory '$app' not found"
    fi

    (
        cd "$app" || handle_error "Failed to enter $app directory"
        
        # Clean, build and install
        echo "    Cleaning previous build..."
        make clean >/dev/null || handle_error "Failed to clean $app"
        
        echo "    Installing $app..."
        sudo make install >/dev/null || handle_error "Failed to install $app"
        
        echo "    Cleaning up..."
        make clean >/dev/null || handle_error "Failed to clean $app"
        
        echo "    Successfully installed $app"
    )
}

# Main execution
if [ $# -eq 0 ]; then
    show_usage
    exit 0
fi

# Validate input arguments
validate_apps "$@"

echo "Starting installation of suckless tools..."

if [ "$1" = "all" ]; then
    for app in "${apps[@]}"; do
        build_install_app "$app"
    done
    install_configs
    echo "All applications and configs installed successfully!"
elif [ "$1" = "configs" ]; then
    install_configs
else
    for app in "$@"; do
        build_install_app "$app"
    done
fi
