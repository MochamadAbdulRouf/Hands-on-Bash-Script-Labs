#!/bin/bash 
# Contoh skrip cek umur

read -p "Masukan umur anda: " UMUR

if [ $UMUR -gt 17 ]; then
    echo "Anda sudah Dewasa"
else 
    echo "Anda masih di Bawah umur"
fi