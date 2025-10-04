#!/bin/bash
# ============================
# Kyo Installer
# ============================

# Central location
KYO_DIR="$HOME/kyo"

# Move folder if needed
if [ ! -d "$KYO_DIR" ]; then
    echo "Creating $KYO_DIR..."
    mkdir -p "$KYO_DIR"
    echo "Please make sure the 'kyo' folder is copied or cloned to $HOME before running this script."
    exit 0
fi

# Make scripts executable
chmod +x "$KYO_DIR/kyo.sh"
chmod +x "$KYO_DIR/scripts/"*.sh

# Create global command
if [ ! -f /usr/local/bin/kyo ]; then
    sudo ln -s "$KYO_DIR/kyo.sh" /usr/local/bin/kyo
fi

# Ensure snapshots and log exist
mkdir -p "$KYO_DIR/snapshots"
touch "$KYO_DIR/kyo.log"

# Done
echo "✅ Kyo installed successfully!"
echo "Try: kyo add test-snapshot"
echo "Snapshots will be stored in: $KYO_DIR/snapshots"
echo "Logs are stored in: $KYO_DIR/kyo.log"
