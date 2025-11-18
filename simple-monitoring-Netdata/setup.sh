#!/bin/bash
# Menginstall dan mengkonfigurasi Netdata

set -e # Keluar segera jika perintah gagal

# Perbarui repositori paket 
echo "Updating package repositories..."
sudo apt-get update -y

# Periksa apakah Netdata sudah terinstal
if ! command -v netdata &> /dev/null
then
    echo "Netdata not found. Starting Installation..."
    # Jalankan skrip install one-liner
    # Menambahkan '--non-interactive' untuk menghindari prompt 
    bash <(curl -Ss https://my-netdata.io/kickstart.sh) --non-interactive
else 
    echo "Netdata is already installed."
fi 

# Pastikan layanan berjalan
echo "enabling and starting Netdata service..."
sudo systemctl enable netdata
sudo systemctl start netdata

echo "___"
echo "Setup complete! Netdata is Running!"
echo "Access Netdata di: http://$(hostname -I / awk '{print $1'}):19999"


