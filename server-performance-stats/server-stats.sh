#!/bin/bash

# =================================================================
#              Server Performance Stats Script By Rouf
# =================================================================
#
# Dibuat untuk menganalisis statistik dasar server Linux.
#

# Fungsi untuk mencetak pemisah
print_separator() {
  printf "%.0s-" {1..70}
  printf "\n"
}

# Fungsi untuk mencetak judul
print_header() {
  print_separator
  echo "### $1"
  print_separator
}

# --- Mulai Laporan ---
echo "================================================================="
echo "             Created By Rouf"
echo "================================================================="
echo

echo "================================================================="
echo "             Laporan Statistik Server - $(date)"
echo "================================================================="
echo

# --- Stretch Goal: Informasi Sistem ---
print_header "Informasi Sistem (Stretch Goal)"
echo "Hostname:         $(hostname)"
# Mengambil nama OS dari /etc/os-release
echo "OS Version:       $(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')"
echo "Kernel Version:   $(uname -r)"
echo "Uptime:           $(uptime -p)"
echo "Load Average:     $(uptime | awk -F'load average: ' '{print $2}')"
echo "Logged-in Users:  $(users | tr ' ' '\n' | sort | uniq | tr '\n' ' ')"
echo
echo

# --- 1. Penggunaan CPU ---
print_header "1. Penggunaan CPU"
# Menggunakan 'top' dalam mode batch, ambil baris CPU, dan hitung 100 - %idle
CPU_USAGE=$(top -b -n 1 | grep "Cpu(s)" | awk '{printf "%.2f%%", 100 - $8}')
echo "Total CPU Usage: $CPU_USAGE"
echo
echo

# --- 2. Penggunaan Memori ---
print_header "2. Penggunaan Memori"
# Menggunakan 'free -m' (dalam megabyte) dan 'awk' untuk memformat output
free -m | grep Mem | awk '{
  total=$2; 
  used=$3; 
  free=$4; 
  used_percent=($3/$2)*100; 
  free_percent=($4/$2)*100;
  
  printf "Total:  %dM\n", total
  printf "Used:   %dM (%.2f%%)\n", used, used_percent
  printf "Free:   %dM (%.2f%%)\n", free, free_percent
}'
echo
echo

# --- 3. Penggunaan Disk ---
print_header "3. Penggunaan Disk (Filesystem Utama)"
# Menggunakan 'df -hP' dan memfilter hanya filesystem yang relevan (mengabaikan tmpfs dll.)
# Header dicetak terlebih dahulu, lalu data yang relevan (dimulai dengan /dev/)
df -hP | head -n 1
df -hP | grep -E '^/dev/'
echo
echo

# --- 4. Top 5 Proses (CPU) ---
print_header "4. Top 5 Proses berdasarkan Penggunaan CPU"
# 'ps' untuk menampilkan proses, diurutkan berdasarkan %cpu secara menurun
ps aux --sort=-%cpu | head -n 6
echo
echo

# --- 5. Top 5 Proses (Memori) ---
print_header "5. Top 5 Proses berdasarkan Penggunaan Memori"
# 'ps' untuk menampilkan proses, diurutkan berdasarkan %mem secara menurun
ps aux --sort=-%mem | head -n 6
echo
echo

# --- Selesai Laporan ---
echo "================================================================="
echo "                     Akhir Laporan"
echo "================================================================="