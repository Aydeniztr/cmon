#!/bin/bash
set -e

SOURCE_URL="https://github.com/Aydeniztr/cmon/archive/refs/heads/main.zip"
TMP_DIR=$(mktemp -d)

# Cleanup on exit
trap "rm -rf $TMP_DIR" EXIT

# Detect Package Manager
if [ -f /etc/debian_version ]; then
    echo "Detected Debian/Ubuntu-based system. Installing dependencies..."
    sudo apt update && sudo apt install -y build-essential libncursesw5-dev curl unzip
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
    echo "Detected Fedora/RHEL-based system. Installing dependencies..."
    sudo dnf install -y gcc make ncurses-devel curl unzip
elif [ -f /etc/arch-release ]; then
    echo "Detected Arch Linux-based system. Installing dependencies..."
    sudo pacman -S --noconfirm base-devel ncurses curl unzip
else
    echo "Warning: Unsupported OS. Please ensure gcc, make, ncurses-devel, curl, and unzip are installed manually."
fi

# Download and Extract in Temp
echo "Downloading cmon source..."
curl -sSL "$SOURCE_URL" -o "$TMP_DIR/source.zip"
unzip -q "$TMP_DIR/source.zip" -d "$TMP_DIR"

# Navigate into the extracted directory (GitHub zips name it <repo>-<branch>)
cd "$TMP_DIR/cmon-main"

echo "Building cmon from source..."
make

# Install to /usr/local/bin
echo "Installing to /usr/local/bin/cmon..."
sudo mv cmon /usr/local/bin/

echo "----------------------------------------"
echo "✅ cmon has been installed successfully!"
echo "Type 'cmon' to start monitoring."
echo "----------------------------------------"
