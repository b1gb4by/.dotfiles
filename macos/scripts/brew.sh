#!/bin/bash

# Exit on error, undefined variables, and errors in pipes
set -euo pipefail

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if running on macOS
check_macos() {
    if [ "$(uname)" != "Darwin" ]; then
        log_error "This script must be run on macOS"
        exit 1
    fi
    log_success "Running on macOS"
}

# Function to verify Homebrew installation
check_homebrew() {
    if ! command_exists brew; then
        log_error "Homebrew is not installed. Please install Homebrew first"
        exit 1
    fi
    log_success "Homebrew is installed"
}

# Function to check for Brewfile
check_brewfile() {
    if [ ! -f "${HOME}/Brewfile" ]; then
        log_error "Brewfile not found in home directory"
        exit 1
    fi
    log_success "Brewfile found"
}

# Function to install packages
install_packages() {
    log_info "Installing packages from Brewfile..."

    # Update Homebrew first
    log_info "Updating Homebrew..."
    if brew update --quiet; then
        log_success "Homebrew updated successfully"
    else
        log_error "Failed to update Homebrew"
        exit 1
    fi

    # Install packages
    if brew bundle --global; then
        log_success "All packages installed successfully"
    else
        log_error "Some packages failed to install"
        exit 1
    fi
}

main() {
    log_info "Starting package installation..."

    # Run checks
    check_macos
    check_homebrew
    check_brewfile

    # Install packages
    install_packages

    log_success "Package installation completed"
}

# Execute main function
main "$@"
