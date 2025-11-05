#!/bin/sh

# =================================================================
#                 Log Archive Tool
# =================================================================
#
# Skrip ini mengambil satu argumen (direktori log),
# mengompresnya ke dalam file .tar.gz dengan stempel waktu,
# menyimpannya di direktori 'log_archives',
# dan mencatat aktivitas ke file 'archive_activity.log'.
#

# --- 1. Validasi Input ---

echo "================================================================="
echo "             Created By Rouf"
echo "================================================================="
echo

# Periksa apakah pengguna memberikan tepat satu argumen
if [ "$#" -ne 1 ]; then
    echo "Kesalahan: Anda harus menyertakan direktori log sebagai argumen."
    echo "Penggunaan:   log-archive <direktori-log>"
    echo "Contoh:   log-archive /var/log"
    exit 1
fi

# Simpan argumen pertama sebagai variabel
LOG_DIR=$1

# Periksa apakah argumen adalah direktori yang ada
if [ ! -d "$LOG_DIR" ]; then
    echo "Kesalahan: Direktori '$LOG_DIR' tidak ditemukan."
    exit 1
fi

# --- 2. Tentukan Variabel ---

# Direktori tujuan (akan dibuat di direktori kerja saat ini)
DEST_DIR="log_archives"

# Stempel waktu untuk nama file (misal: 20251105_133001)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Nama file arsip akhir (sesuai permintaan proyek)
ARCHIVE_FILE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Path lengkap untuk file arsip
TARGET_FILE_PATH="$DEST_DIR/$ARCHIVE_FILE_NAME"

# File log untuk mencatat aktivitas skrip ini
ACTIVITY_LOG="archive_activity.log"

# Pisahkan direktori induk dan direktori target untuk 'tar'
# Ini adalah trik agar 'tar' tidak menyimpan path absolut
# Contoh: /var/log -> PARENT_DIR=/var, CHILD_DIR=log
PARENT_DIR=$(dirname "$LOG_DIR")
CHILD_DIR=$(basename "$LOG_DIR")

# --- 3. Logika Utama ---

echo "Memulai proses arsip untuk: $LOG_DIR"

# Buat direktori tujuan arsip jika belum ada
mkdir -p "$DEST_DIR"

if [ $? -ne 0 ]; then
    echo "Kesalahan: Tidak dapat membuat direktori tujuan '$DEST_DIR'."
    exit 1
fi

echo "Mengompres '$CHILD_DIR' dari '$PARENT_DIR'..."

# Perintah 'tar' untuk mengompres:
# -c : create (buat arsip)
# -z : gzip (kompres dengan gzip)
# -f : file (nama file arsip)
# -C : Change Directory (pindah ke direktori induk sebelum mengarsip)
#
# Menggunakan '-C' sangat penting agar arsip Anda bersih.
# Ini akan mengarsipkan 'log' BUKAN '/var/log'.
# Saat diekstrak, ini akan membuat folder 'log', bukan path '/var/log'.
tar -czf "$TARGET_FILE_PATH" -C "$PARENT_DIR" "$CHILD_DIR"

# Cronjob berikut didalam script akan menjalankan script contoh: log-archive.sh /var/log . (jika itu direktori yang ingin di archive)
# Setiap hari pada jam 02.00
setup_cron() {
    # BARU: Mendapatkan path lengkap ke script ini secara dinamis
    SCRIPT_PATH=$(readlink -f "$0")

    # BARU: Mengambil argumen ($1) yang diberikan ke fungsi
    CRON_ARGUMENT=$1

    # BARU: Validasi agar fungsi ini tidak setup cron jika dijalankan tanpa argumen
    if [ -z "$CRON_ARGUMENT" ]; then
        echo
        echo "Peringatan: Tidak bisa setup cron."
        echo "Harap jalankan script dengan argumen (contoh: $0 /var/log) untuk setup cron."
        return 1 # Keluar dari fungsi
    fi

    echo # Memberi spasi
    read -r -p "Apakah kamu ingin menambahkan script ini ke cronjob supaya setiap hari di eksekusi? (y/n) " choice
    
    case "$choice" in
    y|Y)
            # DIUBAH: cron_line sekarang dinamis dan menyertakan argumen
            cron_line="0 2 * * * $SCRIPT_PATH $CRON_ARGUMENT"
            
            # BARU (Opsional): Pengecekan duplikat agar lebih aman
            if ! crontab -l | grep -Fxq "$cron_line"; then
                (crontab -l 2>/dev/null; echo "$cron_line") | crontab -
                echo "Cron job added: $cron_line"
            else
                echo "Cron job '$cron_line' sudah ada. Tidak ada perubahan."
            fi
            ;;
        *)
            echo "Cron job not added."
            ;;
    esac
}
# Call the cron setup function
setup_cron "$1"


# --- 4. Verifikasi dan Catat Log ---

# Periksa kode keluar (exit code) dari 'tar'
if [ $? -eq 0 ]; then
    # Sukses
    echo "Sukses: Arsip berhasil dibuat di $TARGET_FILE_PATH"
    
    # Tulis log aktivitas ke file (sesuai requirement)
    echo "$(date) | SUKSES | '$LOG_DIR' diarsipkan ke '$TARGET_FILE_PATH'" >> "$ACTIVITY_LOG"
else
    # Gagal
    echo "Kesalahan: Gagal membuat arsip."
    
    # Tulis log aktivitas ke file
    echo "$(date) | GAGAL | Upaya mengarsipkan '$LOG_DIR' gagal" >> "$ACTIVITY_LOG"
    exit 1
fi

echo "Proses pengarsipan selesai."