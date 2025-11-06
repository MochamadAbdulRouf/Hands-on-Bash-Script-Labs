#!/bin/bash

# =================================================================
#                 Nginx Log Analyser
# =================================================================
#
# Deskripsi:
# Script ini membaca file log Nginx.
# - Jika argumen diberikan, file itu yang dianalisis.
# - Jika tidak ada argumen, script akan mencari di 
#   lokasi default: /var/log/nginx/access.log
#
# Penggunaan (Dua Cara):
# 1. (Default): sudo ./nginx-log-analyser.sh
# 2. (Kustom):   ./nginx-log-analyser.sh /path/ke/log_lain.log
#

echo "================================================================="
echo "             Created By Rouf"
echo "================================================================="
echo

# --- 1. Tentukan File Log (LOGIKA BARU) ---

# Tentukan path default
DEFAULT_LOG_FILE="/var/log/nginx/access.log"

# Cek apakah pengguna memberikan argumen
if [ "$#" -eq 1 ]; then
    # Jika ya, gunakan argumen $1 sebagai file log
    LOG_FILE=$1
    echo "Menganalisis file log kustom: $LOG_FILE"
else
    # Jika tidak ada argumen, gunakan file default
    LOG_FILE=$DEFAULT_LOG_FILE
    echo "Tidak ada argumen. Menganalisis file log default: $LOG_FILE"
    
    # Beri petunjuk jika file default tidak bisa diakses
    if [ ! -r "$LOG_FILE" ]; then
        echo "Peringatan: Tidak bisa membaca file default. Anda mungkin perlu 'sudo'."
    fi
fi

# --- 2. Validasi (Sedikit Diubah) ---

# Periksa apakah file log ada DAN bisa dibaca (-r)
if [ ! -r "$LOG_FILE" ]; then
    echo "Kesalahan: File log '$LOG_FILE' tidak ditemukan atau tidak bisa dibaca."
    echo "Pastikan file ada dan Anda memiliki izin (coba 'sudo')."
    exit 1
fi

echo "================================================="

# --- 3. Analisis Log (TIDAK BERUBAH) ---

# (Seluruh 'magic pipeline' awk, sort, uniq, dll. tetap sama persis)

SED_FORMAT="s/^[ ]*([0-9]+) (.*)$/\2 - \1 requests/"

### Top 5 Alamat IP
echo "Top 5 IP addresses with the most requests:"
echo
awk -F'"' '{print $1}' "$LOG_FILE" | awk '{print $1}' | \
    sort | uniq -c | sort -nr | head -n 5 | sed -E "$SED_FORMAT"
echo

### Top 5 Path yang Diminta
echo "Top 5 most requested paths:"
echo
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $2}' | \
    sort | uniq -c | sort -nr | head -n 5 | sed -E "$SED_FORMAT"
echo

### Top 5 Kode Status
echo "Top 5 response status codes:"
echo
awk -F'"' '{print $3}' "$LOG_FILE" | awk '{print $1}' | \
    sort | uniq -c | sort -nr | head -n 5 | sed -E "$SED_FORMAT"
echo

### Top 5 User Agent
echo "Top 5 user agents:"
echo
awk -F'"' '{print $6}' "$LOG_FILE" | \
    sort | uniq -c | sort -nr | head -n 5 | sed -E "$SED_FORMAT"
echo

echo "================================================="
echo "Analisis Selesai."