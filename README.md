# .dotfiles

A modern, efficient dotfiles manager for macOS and Linux systems. This repository contains my personal configuration files and setup scripts to automate development environment configuration.

## 🚀 Features

- **Cross-platform Support**: Works on both macOS and Linux
- **Automated Setup**: One command to set up your entire development environment
- **Modular Design**: Easy to add or remove configurations
- **Safe Installation**: Automatic backup of existing configurations
- **Colorful Logging**: Clear visual feedback during installation
- **Package Management**: Automated tool installation via Homebrew (macOS) or native package managers (Linux)

## 💻 Supported Operating Systems

- macOS (primary)
- Linux (Ubuntu/Debian)

## ⚡ Quick Start

1. Clone the repository:

```shell
git clone https://github.com/yourusername/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the installation:

```shell
make all
```

Or choose specific components to install:

```shell
make help  # Show available commands
```

## 🛠 Available Commands

- `make all`: Execute complete setup process
- `make init`: Set initial system preferences
- `make link`: Create symbolic links for configuration files
- `make brew`: Install Homebrew and packages (macOS only)
- `make tools`: Install development tools

## 📦 Included Configurations

### Shell

- ZSH configuration with custom aliases and functions
- Starship prompt configuration
- Shell environment variables

### Development Tools

- Git configuration and global gitignore
- Neovim configuration
- tmux configuration
- Development tool configurations

### Package Management

- Homebrew packages and casks (macOS)
- System packages (Linux)

## 📄 Project Structure

```shell
.dotfiles/
├── Makefile          # Main installation script
├── macos/            # macOS specific configurations
│   ├── scripts/      # Installation scripts
│   └── .config/      # Configuration files
├── linux/            # Linux specific configurations
│   ├── scripts/      # Installation scripts
│   └── .config/      # Configuration files
└── README.md         # This file
```

## ⚙️ Customization

1. Fork this repository
2. Modify the configurations in `macos/` or `linux/` directories
3. Update the Brewfile or package lists according to your needs
4. Commit your changes and push to your repository

## 🚨 Backup

The installation process will automatically backup any existing configurations by appending `.backup` to the filename. However, it's recommended to manually backup important configurations before installation.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 🙏 Acknowledgments

This dotfiles configuration is inspired by various other dotfiles repositories in the community. Special thanks to:

- [Starship](https://starship.rs/) for the cross-shell prompt
- [Homebrew](https://brew.sh/) for the package management
- The open-source community for various tools and inspiration
