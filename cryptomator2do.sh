#!/bin/bash

# variables
DROPLET_USER="your_username"
DROPLET_IP="your_droplet_ip"
REMOTE_PATH="/path/on/droplet"
VAULT_NAME="myVault"
MOUNT_POINT="$HOME/cryptomator_mount"
VAULT_DIR="$HOME/$VAULT_NAME"
PASSWORD=input("Enter Vault Password...")

# verify root
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root or with sudo."
    exit
fi

echo "Updating packages and installing dependencies..."
apt update -y && apt install -y flatpak curl

echo "Installing Cryptomator CLI..."
curl -LO "https://github.com/cryptomator/cli/releases/latest/download/cryptomator-cli.jar" -o /usr/local/bin/cryptomator-cli.jar
chmod +x /usr/local/bin/cryptomator-cli.jar

# Function to run Cryptomator CLI commands
cryptomator() {
    java -jar /usr/local/bin/cryptomator-cli.jar "$@"
}

# Set up Cryptomator vault directory
mkdir -p "$VAULT_DIR"

# Initialize the vault
echo "Creating Cryptomator vault..."
cryptomator create --password "$PASSWORD" "$VAULT_DIR"

# Unlock the vault
echo "Unlocking the Cryptomator vault..."
cryptomator unlock --password "$PASSWORD" --mount "$MOUNT_POINT" "$VAULT_DIR"

# Copy files to encrypted vault
echo "Copying files to encrypted vault..."
cp -r /path/to/your/data/* "$MOUNT_POINT"  # Replace with actual data source

# Lock the vault
echo "Locking the Cryptomator vault..."
cryptomator lock "$VAULT_DIR"

# Transfer encrypted data to DigitalOcean droplet
echo "Transferring encrypted data to DigitalOcean droplet..."
scp -r "$VAULT_DIR" "$DROPLET_USER@$DROPLET_IP:$REMOTE_PATH"

# Cleanup
echo "Cleaning up mount point..."
umount "$MOUNT_POINT"

echo "Encrypted data has been successfully transferred to your DigitalOcean droplet."
