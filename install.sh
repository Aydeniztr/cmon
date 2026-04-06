#!/bin/bash
set -e

# Detect Package Manager
if [ -f /etc/debian_version ]; then
    echo "Detected Debian/Ubuntu-based system. Installing dependencies..."
    sudo apt update && sudo apt install -y build-essential libncursesw5-dev
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
    echo "Detected Fedora/RHEL-based system. Installing dependencies..."
    sudo dnf install -y gcc make ncurses-devel
elif [ -f /etc/arch-release ]; then
    echo "Detected Arch Linux-based system. Installing dependencies..."
    sudo pacman -S --noconfirm base-devel ncurses
else
    echo "Warning: Unsupported OS. Please ensure gcc, make, and ncurses-devel are installed manually."
fi

# Build
echo "Building cmon..."
make

# Install to /usr/local/bin
echo "Installing to /usr/local/bin/cmon..."
sudo mv cmon /usr/local/bin/

echo "----------------------------------------"
echo "✅ cmon has been installed successfully!"
echo "Type 'cmon' to start monitoring."
echo "----------------------------------------"
