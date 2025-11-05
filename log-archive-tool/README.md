# Log Archive Tools
Disini saya membuat sebuah tools script untuk mengarsipkan direktori /log pada jadwal tertentu dengan menggunakan kombinasi cronjob maka script akan di eksekusi otomatis setiap hari saat jam 02.00. Jadi script ini akan mengompress file dari direktori log dan akan menyimpannya di direktori baru.

## Cara Menjalankan Script

1. Clone repository
```bash
git clone https://github.com/MochamadAbdulRouf/Hands-on-Bash-Script-Labs.git
```

2. Masuk ke direktori log-archive-tool
```bash
cd log-archive-tool
```

3. Berikan izin eksekusi pada file log-archive.sh
```bash
chmod +x log-archive.sh
```

4. Pindahkan file script ke direktori yang mempunyai variable `$PATH` supaya shell dapat menemukan tool ini
```bash
sudo mv log-archive.sh /usr/local/bin/log-archive
```

5. Coba arsipkan direktori `/log/` 
```bash
log-archive /var/log
```

6. Jika ada pertanyaan menambahkan script ke cronjob ketik `y` lalu enter, ini menambahkan cronjob pada file script jadi cronjob akan menjalankan file script ini setiap hari pada jam 02.Jadi otomatis mengarsipkan file di direktori `/log` setiap harinya.

7. Di direktori saat ini akan muncul direktori baru bernama `log_archives` disitulah file yang di kompress disimpan, contoh seperti berikut 
```bash
rouf@rouf:~/script$ ls
archive_activity.log  log_archives
```

8. Jika coba dilihat direktorinya akan berisi file hasil kompress
```bash
rouf@rouf:~/script$ ls log_archives/
logs_archive_20251105_090642.tar.gz  logs_archive_20251105_093946.tar.gz
logs_archive_20251105_081117.tar.gz  logs_archive_20251105_090656.tar.gz  logs_archive_20251105_094001.tar.gz  
logs_archive_20251105_081158.tar.gz  logs_archive_20251105_091718.tar.gz  logs_archive_20251105_100134.tar.gz  
logs_archive_20251105_083302.tar.gz  logs_archive_20251105_091730.tar.gz  logs_archive_20251105_101411.tar.gz  
logs_archive_20251105_083823.tar.gz  logs_archive_20251105_092006.tar.gz
```

9. Script ini juga ada log dari hasil pengarsipan, Jadi ketika cronjob otomatis melakukan arsip pada direktori `/log` maka historynya akan disimpan di file `archive_activity.log`.Contoh seperti berikut
```bash
rouf@rouf:~/script$ sudo log-archive /var/log
[sudo] password for rouf: 
=================================================================
             Created By Rouf
=================================================================

Memulai proses arsip untuk: /var/log
Mengompres 'log' dari '/var'...

Apakah kamu ingin menambahkan script ini ke cronjob supaya setiap hari di eksekusi? (y/n) y
Cron job '0 2 * * * /usr/local/bin/log-archive /var/log' sudah ada. Tidak ada perubahan.
Sukses: Arsip berhasil dibuat di log_archives/logs_archive_20251105_103144.tar.gz
Proses pengarsipan selesai.
rouf@rouf:~/script$ cat archive_activity.log 
Wed Nov  5 08:11:22 AM UTC 2025 | GAGAL | Upaya mengarsipkan '/var/log' gagal
Wed Nov  5 08:12:01 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_081158.tar.gz'
Wed Nov  5 08:33:04 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_083302.tar.gz'
Wed Nov  5 08:38:23 AM UTC 2025 | SUKSES | '/home/rouf/test-dir/' diarsipkan ke 'log_archives/logs_archive_20251105_083823.tar.gz'
Wed Nov  5 09:07:00 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_090656.tar.gz'
Wed Nov  5 09:20:10 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_092006.tar.gz'
Wed Nov  5 09:40:07 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_094001.tar.gz'
Wed Nov  5 10:01:46 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_100134.tar.gz'
Wed Nov  5 10:14:15 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_101411.tar.gz'
Wed Nov  5 10:31:48 AM UTC 2025 | SUKSES | '/var/log' diarsipkan ke 'log_archives/logs_archive_20251105_103144.tar.gz'
```
note: diatas kenapa log cronjob tidak ada perubahan karena saya sudah menambahkannya sebelumnya, Dan history arsip berhasil di perbarui setiap mengarsipkan direktori.