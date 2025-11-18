#!/bin/bash
# Script ini menginstall stress (tool uji beban sistem) dan menggunakannya 
# untuk membuat lonjakan CPU, Sehingga nantinya dapat melihat alarm sistem bekerja di dashboard

set -e 

if ! command -v stress &> /dev/null
then 
    echo "installing 'stress' utility..."
    sudo apt-get install -y stress
else 
    echo "'stress' is already installed."
fi

echo "____"
echo "Starting CPU load test for 60 seconds..."
echo "Buka dashboard Netdata untuk melihat alarm CPU bekerja. di  (http://[IP-SERVER]:19999)"
echo "Perhatikan chart 'system.cpu' dan cek alarm"
echo "____"

# Jalankan stress test: 4 worker CPU, selama 60 detik
stress --cpu 4 --timeout 60s

echo "Load test finished."
