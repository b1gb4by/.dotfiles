#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!!"
	exit 1
fi

# Set bash
chsh -s /bin/bash

# Install xcode
echo "Installing XCode..."
xcode-select --install > /dev/null

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
