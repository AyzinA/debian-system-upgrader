#!/bin/bash

# Load variables from the environment file
set -a
source ./upgrade.env
set +a

echo "Starting upgrade from Debian $CURRENT_VERSION to $NEW_VERSION..."

# Step 1: Confirm OS version
source /etc/os-release
if [[ "$VERSION_CODENAME" != "$CURRENT_VERSION" ]]; then
  echo "This system is not Debian $CURRENT_VERSION. Aborting."
  exit 1
fi

# Step 2: Optional Backup of config and sources
echo "Backing up apt sources and critical config files to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -a /etc/apt "$BACKUP_DIR"
cp -a /etc/apt/sources.list "$BACKUP_DIR/sources.list.bak"
cp -a /etc/apt/sources.list.d "$BACKUP_DIR/sources.list.d"

# Step 3: Update apt sources to Debian 12
echo "Updating APT sources to $NEW_VERSION..."
sed -i "s/$CURRENT_VERSION/$NEW_VERSION/g" /etc/apt/sources.list
sed -i "s/$CURRENT_VERSION/$NEW_VERSION/g" /etc/apt/sources.list.d/*.list 2>/dev/null || true

# Step 4: Update package list
echo "Running apt update..."
apt update

# Step 5: Perform minimal upgrade first
echo "Running minimal upgrade..."
apt upgrade --without-new-pkgs -y

# Step 6: Full distribution upgrade
echo "Running full dist-upgrade to $NEW_VERSION..."
apt full-upgrade -y

# Step 7: Remove obsolete packages
echo "Cleaning up old packages..."
apt autoremove --purge -y

# Step 8: Prompt for reboot
echo "Upgrade complete. It is strongly recommended to reboot now."
read -p "Do you want to reboot now? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    reboot
else
    echo "Reboot later to apply all changes."
fi