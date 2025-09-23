#!/bin/bash

# --- MODIFY BACKUP ---

# Opening
echo "Menjalankan skrip mohon tunggu sebentar..."
sleep 3

read -p "Folder manakah yang ingin anda backup?" NAMA_FOLDER # Kesalahan variabel
SUMBER_FOLDER=$NAMA_FOLDER # Revisi jadi seperti ini
echo "Baik berikut nama folder yang ingin anda backup, $SUMBER_FOLDER!"
echo 
sleep 3


read -p "Ingin backup folder anda dimana?" TUJUAN_FOLDER
echo "Baik anda ingin backup ke $TUJUAN_FOLDER!"
echo 
sleep 3


if [ ! -d "$SUMBER_FOLDER" ]; then
    echo "ERROR : Folder $SUMBER_FOLDER yang ingin dibackup tidak bisa ditemukan"
    echo "Proses backup di BATALKAN!"
    exit 1
fi

TANGGAL=$(date +"%Y-%m-%d_%H-%M-\%S")
NAMA_FILE_BACKUP="backup-$TANGGAL.tar.gz"

echo "Memulai dan Mempersiapkan Backup..."
sleep 3


if [ ! -d "$TUJUAN_FOLDER" ]; then
    echo "Folder Tujuan tidak di temukan. Membuat Folder $TUJUAN_FOLDER..."
    mkdir -p "$TUJUAN_FOLDER"
fi


echo "Mengompress file.. ini mungkin membutuhkan waktu"
tar -czf "$TUJUAN_FOLDER/$NAMA_FILE_BACKUP" "$SUMBER_FOLDER"
sleep 5

echo "Backup telah berhasil dilakukan..."
echo "File backup disimpan di: $TUJUAN_FOLDER/$NAMA_FILE_BACKUP"



# KESALAHAN SAYA SAAT MEMPELAJARI INI
# 1. Variabel masih tidak konsisten
# 2. Kesalahan logika 
# 3. Perbaikan kecil format tanggal

