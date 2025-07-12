#!/bin/bash
set -e

[ "$(id -u)" -eq 0 ] || { echo "This script needs to be run as root."; exit 1; }

echo "--- Updating packages and installing tools ---"
apt update -y
apt install -y zram-config earlyoom

echo "--- Backup of /etc/fstab ---"
cp /etc/fstab /etc/fstab.bak

echo "--- Disabling and removing swapfile ---"
swapoff -a
sed -i '/ swap /d' /etc/fstab
[ -f /swapfile ] && rm -f /swapfile

echo "--- Enabling zram-config ---"
systemctl enable zram-config
systemctl restart zram-config

echo "--- Enabling EarlyOOM (OOM Killer) ---"
systemctl enable earlyoom
systemctl start earlyoom

echo "--- Remounting root (/) with new options, if applicable ---"
mount -o remount /

echo -e "\n✅ \033[1;32mConfiguration completed successfully!\033[0m"
echo -e "\n📊 Final checks:\n"

echo "🔹 Zram:"
zramctl || echo "(zramctl not available)"

echo -e "\n🔹 Fstab:"
grep btrfs /etc/fstab || echo "(No Btrfs entries found)"

if command -v btrfs &>/dev/null && grep -q btrfs /etc/fstab; then
    echo -e "\n🔹 Btrfs:"
    btrfs filesystem show /
fi

echo -e "\n🔁 You can now reboot the system to fully apply the changes."
