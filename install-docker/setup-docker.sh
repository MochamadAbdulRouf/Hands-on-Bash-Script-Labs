#!/bin/bash
# install_docker.sh
# Script instalasi Docker otomatis untuk Ubuntu/Debian

set -e  # Script akan berhenti otomatis jika ada error

# Warna untuk output agar mudah dibaca
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}[1/6] Mengupdate sistem dan menginstal dependensi dasar...${NC}"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

echo -e "${GREEN}[2/6] Menyiapkan direktori Keyrings...${NC}"
sudo install -m 0755 -d /etc/apt/keyrings

# Hapus key lama jika ada (untuk menghindari error conflict saat re-install)
if [ -f "/etc/apt/keyrings/docker.gpg" ]; then
    sudo rm /etc/apt/keyrings/docker.gpg
fi

echo -e "${GREEN}[3/6] Menambahkan GPG Key resmi Docker...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo -e "${GREEN}[4/6] Menambahkan Repository Docker ke Apt sources...${NC}"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "${GREEN}[5/6] Menginstal Docker Engine, CLI, dan Containerd...${NC}"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo -e "${GREEN}[6/6] Mengatur hak akses User (Non-Root)...${NC}"
# Membuat grup docker jika belum ada
if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi

# Menambahkan user saat ini ke grup docker
sudo usermod -aG docker $USER

echo "--------------------------------------------------------"
echo -e "${GREEN}✅ Instalasi Docker Selesai!${NC}"
echo "Versi Docker:"
docker --version
echo "Versi Compose:"
docker compose version
echo "--------------------------------------------------------"
echo "⚠️  PENTING: Agar bisa menjalankan docker tanpa 'sudo', silakan:"
echo "1. Logout dan Login kembali (atau restart server), ATAU"
echo "2. Jalankan perintah ini sekarang: newgrp docker"
echo "--------------------------------------------------------"