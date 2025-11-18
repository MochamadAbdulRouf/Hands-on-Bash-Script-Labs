#!/bin/bash
# Menghapus Netdata dan dependesinya dari sistem

set -e 

# Hentikan layanan jika berjalan
echo "--- Starting Netdata cleanup ---"
sudo systemctl stop netdata || true
sudo systemctl disable netdata || true

# coba menguninstall menggunakan paket manager
if dpkg -l | grep -q netdata; then
    echo "Removing Netdata via apt.."
    sudo apt-get purge -y netdata
else 
    echo "Netdata package not found in apt. Proceeding to manual deletion..."
fi

# Coba jalankan uninstaller script jika kebetulan ada (sebagai cadangan)
if [ -f "/usr/libexec/netdata/netdata-uninstaller.sh"]; then
    echo "Running uninstaller script..."
    sudo /usr/libexec/netdata/netdata-uninstaller.sh --yes --force || true
fi

# Hapus direktori Netdata jika masih ada
echo "Cleaning up leftover directories..."
sudo rm -rf /etc/netdata || true
sudo rm -rf /var/lib/netdata || true
sudo rm -rf /var/cache/netdata || true
sudo rm -rf /var/log/netdata || true
sudo rm -rf /usr/libexec/netdata || true
sudo rm -rf /usr/share/netdata || true
sudo rm -rf /opt/netdata || true

# Hapus user dan grup netdata jika ada
echo "Removing netdata user and group..."
sudo userdel netdata 2>/dev/null || true
sudo groupdel netdata 2>/dev/null || true


# Hapus stress jika di install
if command -v stress &> /dev/null
then 
    echo "Removing 'stress' utility..."
    sudo apt-get remove -y stress
    sudo apt-get autoremove -y
fi 

echo "Cleanup complete."