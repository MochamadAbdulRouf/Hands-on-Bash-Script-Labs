#!/bin/bash

# --- Variabel konfigurasi ---
# Folder yang ingin di backup
FOLDER_SUMBER="/home/user/dokumen_penting"

# Folder tujuan untuk menyimpan backup
FOLDER_TUJUAN="/home/user/backup"

# --- LOGIKA Skrip ---

# Buat nama file backup yang unik dengan format tanggal
TANGGAL=$(date +"%Y-%m-%d_%H-%M=%S")
NAMA_FILE_BACKUP="backup-$TANGGAL.tar.gz"


echo "Memulai proses backup"

# Cek apakah folder sumber menjadi file .tar.gz di folder tujuan
if [ ! -d "FOLDER_TUJUAN" ]; then
    echo "FOLDER tujuan tidak ditemukan. Mmebuat folder $FOLDER_TUJUAN..."
    mkdir -p "$FOLDER_TUJUAN"
fi

# Mengompress file sumber menjadi .tar.gz di folder tujuan
# tar -czf (nama-file-hasil) (folder-sumber)
tar -czf "$FOLDER_TUJUAN/$NAMA_FILE_BACKUP" "$FOLDER_SUMBER"

# Memberikan pesan konfirmasi jika berhasil
echo "Backup berhasil dibuat!"
echo "File backup disimpan di: $FOLDER_TUJUAN/$NAMA_FILE_BACKUP"