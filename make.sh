#!/usr/bin/env bash

# List of applications to build and install
apps=("dwm" "st" "slstatus" "tabbed" "dmenu" "slock")

# Function to show usage
show_usage() {
    echo "Usage: $0 [all | app_name...]"
    echo "Build and install suckless tools."
    echo
    echo "Options:"
    echo "  all         Build and install all applications"
    echo "  app_name    Build specific application(s)"
    echo
    echo "Available applications:"
    printf "  %s\n" "${apps[@]}"
    echo
    echo "Examples:"
    echo "  $0 all          # Build all applications"
    echo "  $0 dwm st       # Build only dwm and st"
    echo
}

# Function to validate app names
validate_apps() {
    local app
    for app in "$@"; do
        if [[ "$app" != "all" ]] && [[ ! " ${apps[@]} " =~ " ${app} " ]]; then
            handle_error "Invalid application: $app"
        fi
    done
}

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Function to build and install an application
build_install_app() {
    local app="$1"
    echo "==> Building and installing $app..."
    
    if [[ ! -d "$app" ]]; then
        handle_error "Directory '$app' not found"
    fi

    (
        cd "$app" || handle_error "Failed to enter $app directory"
        
        # Remove config.h if it exists
        if [[ -f config.h ]]; then
            echo "    Removing existing config.h"
            rm -f config.h || handle_error "Failed to remove config.h"
        fi
        
        # Clean, build and install
        echo "    Cleaning previous build..."
        sudo make clean >/dev/null || handle_error "Failed to clean $app"
        
        echo "    Installing $app..."
        sudo make install >/dev/null || handle_error "Failed to install $app"
        
        echo "    Cleaning up..."
        sudo make clean >/dev/null || handle_error "Failed to clean $app"
        
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
    echo "All applications installed successfully!"
else
    for app in "$@"; do
        build_install_app "$app"
    done
fi
