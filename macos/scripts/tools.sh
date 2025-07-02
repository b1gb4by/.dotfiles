#!/bin/bash

# Install AstroNvim
echo "Installing AstroNvim"
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
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

# Function to check requirements
check_requirements() {
    log_info "Checking requirements..."

    # Check for git
    if ! command_exists git; then
        log_error "git is not installed"
        exit 1
    fi

    # Check for nvim
    if ! command_exists nvim; then
        log_error "neovim is not installed"
        exit 1
    fi

    log_success "All requirements satisfied"
}

# Function to check existing installation
check_existing() {
    if [ -d "${HOME}/.config/nvim" ]; then
        log_warning "Existing Neovim configuration found"
        log_warning "Please backup and remove ~/.config/nvim before installation"
        exit 1
    fi
}

# Function to install AstroNvim
install_astronvim() {
    log_info "Installing AstroNvim..."

    if git clone --depth 1 https://github.com/AstroNvim/template "${HOME}/.config/nvim"; then
        log_success "AstroNvim installed successfully"
    else
        log_error "Failed to install AstroNvim"
        exit 1
    fi
}

main() {
    log_info "Starting AstroNvim installation..."

    # Run checks
    check_requirements
    check_existing

    # Install AstroNvim
    install_astronvim

    log_success "Installation completed successfully"
    log_info "Please restart Neovim to complete the setup"
}

# Execute main function
main "$@"
