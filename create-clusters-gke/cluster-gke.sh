#!/bin/bash

# Mencetak setiap perintah ke terminal tepat sebelum perintah itu di eksekusi, dengan semua variabel yang sudah diganti nilainya.Ini akan membuat 
# Bisa melihat dengan jelas apa yang sedang dikerjaka script. 
set -x

# Fungsi ini di definisikan namun tidak pernah dipanggil dalam script ini.
# Script ini jika ada perintah yang gagal, script akan tetap mencoba melanjutkan progressnya.
function raise_error {
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "Failing deployment due to error in: $1"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  gcloud beta runtime-config configs variables set \
           failure/workstation-waiter \
           failure --config-name workstation-installer-config
}

# Ini akan mengatur konfigurasi gcloud di mesin saat ini agar menggunakan zona yang baru saja diambil sebagai default untuk semua perintah gcloud berikutnya.
export ZONE=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-zone])")

gcloud config set compute/zone $ZONE

### Membuat cluster GKE baru dengan nama "cluster-fortuneapp" dengan 2 node, masing-masing menggunakan tipe mesin "e2-standard-2".
gcloud container clusters create cluster-fortuneapp --num-nodes 2 --machine-type e2-standard-2 --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"
# gcloud container clusters create-auto valkyrie-dev --region us-central1 --scopes https://www.googleapis.com/auth/source.read_write,cloud-platform

sleep 15

# Mengambil informarsi kredensial untuk cluster yang baru dibuat
# Secara otomatis, perintah ini juga akan mengkonfigurasi kubectl (alat CLI untuk Kubernetes) di mesin agar terhubung ke cluster baru ini.
gcloud container clusters get-credentials cluster-fortuneapp
