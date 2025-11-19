#!/bin/bash
# resize_root.sh
# Script untuk memperbesar Root LVM menggunakan sisa ruang disk yang tersedia.

set -e # Stop script jika terjadi error

# Warna untuk output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Cek akses root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: Script ini harus dijalankan sebagai root (sudo).${NC}"
  exit 1
fi

echo -e "${GREEN}--- Memulai Proses Resize Root LVM ---${NC}"

# 2. Deteksi Logical Volume yang dipakai oleh Root (/)
ROOT_LV=$(findmnt / -o SOURCE -n)
FS_TYPE=$(findmnt / -o FSTYPE -n)

echo -e "Root filesystem terdeteksi di: ${YELLOW}$ROOT_LV${NC}"
echo -e "Tipe filesystem: ${YELLOW}$FS_TYPE${NC}"

# 3. Tampilkan kondisi sebelum resize
echo -e "\n${YELLOW}[Sebelum Resize]${NC}"
df -h /

# 4. Lakukan Extend LVM (Mengambil 100% sisa free space di Volume Group)
echo -e "\n${GREEN}[1/2] Memperluas Logical Volume...${NC}"
lvextend -l +100%FREE "$ROOT_LV"

# 5. Resize Filesystem sesuai tipenya
echo -e "${GREEN}[2/2] Meresize Filesystem agar mengenali ruang baru...${NC}"

if [ "$FS_TYPE" == "ext4" ]; then
    resize2fs "$ROOT_LV"
elif [ "$FS_TYPE" == "xfs" ]; then
    xfs_growfs /
else
    echo -e "${RED}Tipe filesystem $FS_TYPE tidak didukung script ini otomatis.${NC}"
    exit 1
fi

# 6. Verifikasi Hasil
echo -e "\n${GREEN}--- Selesai! Hasil Akhir: ---${NC}"
df -h /