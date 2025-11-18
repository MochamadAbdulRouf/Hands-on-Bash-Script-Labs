#!/bin/bash
# Menghapus Netdata dan dependesinya dari sistem

set -e 

UNINSTALLER="/usr/libexec/netdata/netdata-uninstaller.sh"

if [ -f "$UNINSTALLER"]; then
    echo "Running Netdata uninstaller..."
    sudo $UNINSTALLER --force 
else
    echo "Netdata uninstaller not found at $UNINSTALLER"
    echo "Perhaps Netdata is not installed or path different."
fi 

# Hapus stress jika di install
if command -v stress &> /dev/null
then 
    echo "Removing 'stress' utility..."
    sudo apt-get remove -y stress
    sudo apt-get autoremove -y
fi 

echo "Cleanup complete."