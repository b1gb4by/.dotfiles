#!/bin/bash

# Exit on error, undefined variables, and errors in pipes
set -euo pipefail

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Directory definitions
DOTFILES_DIR="${HOME}/.dotfiles/macos"
CONFIG_DIR="${DOTFILES_DIR}/.config"
CONFIG_HOME="${HOME}/.config"

# Logging functions
log_info() {
    printf "%b[*]%b %s\n" "${BLUE}" "${NC}" "$1"
}

log_success() {
    printf "%b[+]%b %s\n" "${GREEN}" "${NC}" "$1"
}

log_warning() {
    printf "%b[!]%b %s\n" "${YELLOW}" "${NC}" "$1"
}

log_error() {
    printf "%b[-]%b %s\n" "${RED}" "${NC}" "$1" >&2
}

# Function to create symbolic link
create_link() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        log_warning "Source file not found: $src"
        return 1
    fi

    if [ -L "$dest" ]; then
        log_info "Updating existing symlink: $dest"
    elif [ -e "$dest" ]; then
        log_info "Backing up existing file: $dest"
        mv "$dest" "${dest}.backup"
    fi

    ln -sfn "$src" "$dest" && log_success "Created symlink: $dest" || log_error "Failed to create symlink: $dest"
}

# Function to ensure config directory exists
ensure_config_dir() {
    if [ ! -d "$CONFIG_HOME" ]; then
        log_info "Creating config directory: $CONFIG_HOME"
        mkdir -p "$CONFIG_HOME"
    fi
}

main() {
    log_info "Starting dotfiles setup..."

    # Ensure ~/.config exists
    ensure_config_dir

    # Home directory dotfiles
    log_info "Setting up home directory dotfiles..."
    local home_files=(
        ".zshrc"
        ".zprofile"
        ".gitconfig"
        #".vimrc"
        #".tmux.conf"
        "Brewfile"
    )

    for file in "${home_files[@]}"; do
        create_link "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
    done

    # Config directory files
    log_info "Setting up .config directory files..."
    local config_files=(
        "sheldon"
        "git"
        "starship.toml"
        "topgrade.toml"
    )

    for file in "${config_files[@]}"; do
        create_link "${CONFIG_DIR}/${file}" "${CONFIG_HOME}/${file}"
    done

    log_success "Dotfiles setup completed successfully!"
}

# Execute main function
main "$@"
