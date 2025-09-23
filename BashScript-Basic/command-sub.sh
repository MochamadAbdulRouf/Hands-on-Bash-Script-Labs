#!/bin/bash
# COMMAND SUBSTITUTION
# Menyimpan output dari sebuah perintah ke dalam sebuah variabel

# Menjalankan perintah `whoami` dan menyimpan hasilnya di variabel PENGGUNA_SAAT_INI
PENGGUNA_SAAT_INI=$(whoami)
echo "Anda sedang login sebagai: $PENGGUNA_SAAT_INI"

# Menjalankan perintah `date` dan menyimpan hasilnya
TANGGAL_HARI_INI=$(date)
echo "Waktu sekarang adalah: $TANGGAL_HARI_INI"
