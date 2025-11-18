#!/bin/bash
# Menghapus Netdata dan dependesinya dari sistem

set -e 

echo "Starting Netdata cleanup..."

# Mencari lokasi uninstaller yang valid
if [ -f "/usr/libexec/netdata/netdata-uninstaller.sh" ]; then
    UNINSTALLER="/usr/libexec/netdata/netdata-uninstaller.sh"
elif [ -f "/opt/netdata/usr/libexec/netdata/netdata-uninstaller.sh" ]; then
    UNINSTALLER="/opt/netdata/usr/libexec/netdata/netdata-uninstaller.sh"
else
    UNINSTALLER=""
fi

# Eksekusi Uninstaller jika ditemukan
if [ -n "$UNINSTALLER" ] && [ -f "$UNINSTALLER" ]; then
    echo "Found Netdata uninstaller at: $UNINSTALLER"
    echo "Running Netdata uninstaller..."
    
    # Menambahkan --yes --force untuk otomatisasi penuh tanpa prompt
    sudo "$UNINSTALLER" --yes --force
else
    echo "Error: Netdata uninstaller script not found!"
    echo "Mungkin Netdata sudah terhapus atau lokasi instalasi berbeda."
    echo "Coba cari manual dengan: find / -name netdata-uninstaller.sh"
fi

# Hapus stress jika di install
if command -v stress &> /dev/null
then 
    echo "Removing 'stress' utility..."
    sudo apt-get remove -y stress
    sudo apt-get autoremove -y
fi 

echo "Cleanup complete."