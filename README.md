# Debian 11 to Debian 12 Upgrade Script

This repository provides a safe, automated script to upgrade a Debian 11 (Bullseye) system to Debian 12 (Bookworm).

## Files

- `upgrade.env`: Environment configuration file
- `upgrade-to-debian12.sh`: Shell script to perform the upgrade
- `README.md`: Documentation

## Prerequisites

- Root access to the system
- Internet access for package downloads
- Backup of important files is strongly recommended

## How to Use

1. Clone this repository or download the files to your Debian 11 system.

2. Make the script executable:

   ```bash
   chmod +x upgrade-to-debian12.sh
   ```

3. Run the script as root or with `sudo`:

   ```bash
   sudo ./upgrade-to-debian12.sh
   ```

4. Follow the prompts. The script will:
   - Verify you are on Debian 11
   - Backup APT configuration
   - Update sources to Debian 12
   - Perform a minimal upgrade
   - Execute a full distribution upgrade
   - Prompt for reboot after upgrade

## Notes

- Ensure `/etc/apt/sources.list` points to official Debian repositories (`deb.debian.org`) and does not include incompatible third-party sources.
- The script does not handle third-party software reinstallation (e.g., Docker, NVIDIA drivers).
- This upgrade may take time depending on your internet speed and system performance.

## License

This script is provided as-is with no warranty. Use at your own risk.