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

# Function to check if a command exists
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

# Function to set default shell
set_default_shell() {
    local shell_path="/bin/bash"

    if [ "$SHELL" != "$shell_path" ]; then
        log_info "Setting default shell to bash..."
        if chsh -s "$shell_path"; then
            log_success "Default shell changed to bash"
        else
            log_error "Failed to change default shell"
            return 1
        fi
    else
        log_info "Bash is already the default shell"
    fi
}

# Function to install Xcode Command Line Tools
install_xcode() {
    if command_exists xcodebuild; then
        log_info "Xcode Command Line Tools are already installed"
        return 0
    fi

    log_info "Installing Xcode Command Line Tools..."

    # Start installation
    if xcode-select --install 2>/dev/null; then
        # Wait for installation to complete
        until command_exists xcodebuild; do
            echo -n "."
            sleep 1
        done
        echo
        log_success "Xcode Command Line Tools installed successfully"
    else
        log_warning "Xcode Command Line Tools are either already installed or an error occurred"
    fi

    # Verify installation
    if ! command_exists xcodebuild; then
        log_error "Xcode Command Line Tools installation failed"
        return 1
    fi
}

# Function to install Homebrew
install_homebrew() {
    if command_exists brew; then
        log_info "Homebrew is already installed"
        # Update Homebrew
        log_info "Updating Homebrew..."
        brew update --quiet
        log_success "Homebrew updated successfully"
        return 0
    fi

    log_info "Installing Homebrew..."

    # Install Homebrew
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        # Add Homebrew to PATH for the current session
        eval "$(/opt/homebrew/bin/brew shellenv)"
        log_success "Homebrew installed successfully"
    else
        log_error "Failed to install Homebrew"
        return 1
    fi

    # Verify installation
    if ! command_exists brew; then
        log_error "Homebrew installation cannot be verified"
        return 1
    fi
}

# Main function
main() {
    log_info "Starting macOS setup..."

    # Check if running on macOS
    check_macos

    # Set default shell
    set_default_shell

    # Install Xcode Command Line Tools
    install_xcode

    # Install Homebrew
    install_homebrew

    log_success "macOS setup completed successfully!"
}

# Execute main function
main "$@"
