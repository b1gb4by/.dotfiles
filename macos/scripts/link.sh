#!/bin/bash

DOTFILES_DIR=~/.dotfiles/macos/
CONFIG_DIR=$DOTFILES_DIR/.config

echo "Create a symbolic link to the configuration file"
echo "Remove existing files"

rm -f ~/.config/sheldon
rm -f ~/.config/git
rm -f ~/.config/starship.toml
rm -f ~/.config/topgrade.toml
rm -f ~/.zshrc
rm -f ~/.zprofile
rm -f ~/.profile
rm -f ~/.gitconfig
rm -f ~/.vimrc
rm -f ~/.tmux.conf
rm -f ~/Brewfile

echo "Create symbolic links (~/*)"

ln -sv $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sv $DOTFILES_DIR/.zprofile ~/.zprofile
ln -sv $DOTFILES_DIR/.gitconfig ~/.gitconfig
#ln -sv $DOTFILES_DIR/.vimrc ~/.vimrc
ln -sv $DOTFILES_DIR/Brewfile ~/Brewfile
# ln -sv $DOTFILES_DIR/.tmux.conf ~/.tmux.conf

echo "Create symbolic links (~/.config/*)"

ln -sv $CONFIG_DIR/sheldon ~/.config/sheldon
ln -sv $CONFIG_DIR/git ~/.config/git
ln -sv $CONFIG_DIR/starship.toml ~/.config/starship.toml
ln -sv $CONFIG_DIR/topgrade.toml ~/.config/topgrade.toml
