#!/bin/bash
# install terraform.sh
# Script instalasi Terraform otomatis (HashiCorp Official Repo)

set -e  # Berhenti jika ada error

# Definisi warna untuk output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}[1/5] Mengupdate sistem dan menginstal dependensi prasyarat...${NC}"
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl lsb-release

echo -e "${BLUE}[2/5] Menambahkan HashiCorp GPG Key...${NC}"
# Hapus key lama jika ada untuk mencegah konflik
if [ -f "/usr/share/keyrings/hashicorp-archive-keyring.gpg" ]; then
    sudo rm /usr/share/keyrings/hashicorp-archive-keyring.gpg
fi

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo -e "${BLUE}[3/5] Menambahkan Repository HashiCorp...${NC}"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

echo -e "${BLUE}[4/5] Menginstal Terraform...${NC}"
sudo apt-get update
sudo apt-get install -y terraform

echo -e "${BLUE}[5/5] Mengaktifkan Autocomplete...${NC}"
# Menginstall autocomplete agar bisa tekan TAB saat mengetik perintah terraform
terraform -install-autocomplete || true

echo "--------------------------------------------------------"
echo -e "${GREEN}✅ Instalasi Selesai!${NC}"
echo "Versi terinstal:"
terraform --version
echo "--------------------------------------------------------"
echo "⚠️  Catatan: Untuk mengaktifkan autocomplete, silakan restart terminal"
echo "   atau jalankan perintah: source ~/.bashrc"
echo "--------------------------------------------------------"