#!/bin/bash

# --- MODIFY BACKUP ---

# Opening
# Ini adalah command pertama yang di eksekusi saat menjalankan skrip
echo "Menjalankan skrip mohon tunggu sebentar..."
sleep 3 # Sleep Agar memberikan jarak waktu antar command

# Untuk menanyakan folder mana yang ingin dibackup user
read -p "Folder manakah yang ingin anda backup?" NAMA_FOLDER # 'Kesalahan variabel'
SUMBER_FOLDER=$NAMA_FOLDER # 'Revisi jadi seperti ini'
# Merespon dan memberitahu user tentang nama folder yang akan di backup
echo "Baik berikut nama folder yang ingin anda backup, $SUMBER_FOLDER!"
echo # Menambah baris kosong agar rapi
sleep 3

# Menanyakan pada user tujuan folder dibackup kemana
read -p "Ingin backup folder anda dimana?" TUJUAN_FOLDER
# Merespon output user dan memberitahu nama tujuan dimana folder dibackup
echo "Baik anda ingin backup ke $TUJUAN_FOLDER!"
echo 
sleep 3

# Mengecek apakah folder yang ingin dibackup benar benar ada?
if [ ! -d "$SUMBER_FOLDER" ]; then
    echo "ERROR : Folder $SUMBER_FOLDER yang ingin dibackup tidak bisa ditemukan"
    echo "Proses backup di BATALKAN!"
    exit 1 # Jika tidak ada akan eror 'exit 1'
fi

# Memberikan nama unik untuk folder yang akan di kompress menjadi ektensi .tar.gz
# Memberikan nama unik sesuai tanggal
TANGGAL=$(date +"%Y-%m-%d_%H-%M-\%S")
NAMA_FILE_BACKUP="backup-$TANGGAL.tar.gz"

echo "Memulai dan Mempersiapkan Backup..."
sleep 3

# Mengecek folder yang ingin dijadikan tujuan backup apakah ada
# Jika tidak ada skrip akan membuatkan folder tersebut
if [ ! -d "$TUJUAN_FOLDER" ]; then
    echo "Folder Tujuan tidak di temukan. Membuat Folder $TUJUAN_FOLDER..."
    mkdir -p "$TUJUAN_FOLDER"
fi

# Mengompress folder dan isinya menjadi ektensi .tar.gz disertai nama unik menurut tanggal
echo "Mengompress folder dan file didalam folder.. ini mungkin membutuhkan waktu"
tar -czf "$TUJUAN_FOLDER/$NAMA_FILE_BACKUP" "$SUMBER_FOLDER"
sleep 5

# Memberitahu user jika backup telah berhasil dilakukan 
# Memberitahu user jika folder dan file yang di kompress dibackup sesuai inputan user
echo "Backup telah berhasil dilakukan..."
echo "File backup disimpan di: $TUJUAN_FOLDER/$NAMA_FILE_BACKUP"



# KESALAHAN SAYA SAAT MEMPELAJARI INI
# 1. Variabel masih tidak konsisten
# 2. Kesalahan logika 
# 3. Perbaikan kecil format tanggal

