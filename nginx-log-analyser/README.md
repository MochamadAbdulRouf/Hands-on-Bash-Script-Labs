# Nginx Log Analyser
Di project ini saya membuat sebuah tools script yang berguna untuk mengambil data log dari webserver nginx, script ini akan mengambil data data berikut:
- 1. Top 5 IP Address request
- 2. Top 5 Most request paths
- 3. Top 5 Response status codes
- 4. Top 5 User agents

## Implementasi
1. Download file script
```bash
curl -L -O https://raw.githubusercontent.com/MochamadAbdulRouf/Hands-on-Bash-Script-Labs/refs/heads/master/nginx-log-analyser/nginx-log-analyser.sh
```

2. Beri izin eksekusi
```bash
chmod +x nginx-log-analyser.sh
```

3. Jalankan file script
```bash
./nginx-log-analyser.sh
```

4. Berikut contoh output yang keluar dari hasil script
```bash
rouf@rouf:~/script$ ./nginx-log-analyser.sh 
=================================================================
             Created By Rouf
=================================================================

Tidak ada argumen. Menganalisis file log default: /var/log/nginx/access.log
=================================================
Top 5 IP addresses with the most requests:

10.10.10.1 - 8 requests

Top 5 most requested paths:

/ - 7 requests
/favicon.ico - 1 requests

Top 5 response status codes:

304 - 6 requests
404 - 1 requests
200 - 1 requests

Top 5 user agents:

Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 - 8 requests

=================================================
Analisis Selesai.
```

5. Script bisa digabung menggunakan argumen path tertentu jika file konfigurasi nginx dipindahkan ke path tertentu, jadi contohnya seperti berikut
```bash
./nginx-log-analyser.sh /var/pathanda/log/nginx/access.log
```