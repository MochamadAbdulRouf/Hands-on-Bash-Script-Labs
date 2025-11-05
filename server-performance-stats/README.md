# Simple Project Bash Script 
## Server Performance Stats

Script ini berguna untuk membuat laporan mengenai performa dari stats sistem os linux untuk mendapatkan informasi mengenai Penggunaan CPU, Penggunaan Memori, Pengunaan Disk, dll. Bisa dilihat hasil lebih lengkap di bagian bawah sendiri ada contoh output yang keluar dari hasil script.Jadi ini berguna saat ingin melihat spesifik stats dari sebuah sistem os karena tidak membutuhkan waktu lama untuk mengecek stats sistem dengan melihatnya satu persatu, dengan menggunakan script ini membuat semua stats masuk ke dalam satu laporan, Script ini bekerja di semua jenis OS LINUX.

1. Copy code repository
```bash
git clone https://github.com/MochamadAbdulRouf/Hands-on-Bash-Script-Labs.git
```

2. Masuk ke direktori yang berisi script server stat
```bash
cd server-performance-stats
```

3. Beri izin eksekusi pada file script
```bash
chmod +x server-stats.sh
```

4. Jalankan file scriptnya
```bash
./server-stats.sh
```

5. Contoh Output yang muncul ketika script berhasil berjalan
```bash
rouf@rouf:~/script$ ./server-stats.sh
=================================================================
             Laporan Statistik Server - Tue Nov  4 07:27:48 PM UTC 2025
=================================================================

----------------------------------------------------------------------
### Informasi Sistem (Stretch Goal)
----------------------------------------------------------------------
Hostname:         rouf
OS Version:       Ubuntu 24.04.3 LTS
Kernel Version:   6.8.0-86-generic
Uptime:           up 21 minutes
Load Average:     0.02, 0.06, 0.16
Logged-in Users:  rouf


----------------------------------------------------------------------
### 1. Penggunaan CPU
----------------------------------------------------------------------
Total CPU Usage: 12.50%


----------------------------------------------------------------------
### 2. Penggunaan Memori
----------------------------------------------------------------------
Total:  1968M
Used:   561M (28.51%)
Free:   713M (36.23%)


----------------------------------------------------------------------
### 3. Penggunaan Disk (Filesystem Utama)
----------------------------------------------------------------------
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv   23G  7.1G   15G  33% /
/dev/sda2                          2.0G  197M  1.6G  11% /boot


----------------------------------------------------------------------
### 4. Top 5 Proses berdasarkan Penggunaan CPU
----------------------------------------------------------------------
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rouf        2736  100  0.2  12316  5248 pts/0    R+   19:27   0:00 ps aux --sort=-%cpu
root        1336  3.2  3.1 1266292 62744 ?       Ssl  19:07   0:39 /usr/bin/cadvisor -logtostderr
472         1350  2.1 12.6 1743736 255504 ?      Ssl  19:07   0:26 grafana server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini --packaging=docker cfg:default.log.mode=console cfg:default.paths.data=/var/lib/grafana cfg:default.paths.logs=/var/log/grafana cfg:default.paths.plugins=/var/lib/grafana/plugins cfg:default.paths.provisioning=/etc/grafana/provisioning
rouf        2707  1.9  0.1   7340  3584 pts/0    S+   19:27   0:00 /bin/bash ./server-stats.sh
root        2324  1.3  2.1 669488 42824 ?        Ssl  19:19   0:06 /usr/libexec/fwupd/fwupd


----------------------------------------------------------------------
### 5. Top 5 Proses berdasarkan Penggunaan Memori
----------------------------------------------------------------------
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
472         1350  2.1 12.6 1743736 255504 ?      Ssl  19:07   0:26 grafana server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini --packaging=docker cfg:default.log.mode=console cfg:default.paths.data=/var/lib/grafana cfg:default.paths.logs=/var/log/grafana cfg:default.paths.plugins=/var/lib/grafana/plugins cfg:default.paths.provisioning=/etc/grafana/provisioning
nobody      1338  0.6  4.7 1430296 94988 ?       Ssl  19:07   0:07 /bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus
root         869  0.4  4.0 1949756 81060 ?       Ssl  19:07   0:06 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
root        1336  3.2  3.1 1266292 62744 ?       Ssl  19:07   0:39 /usr/bin/cadvisor -logtostderr
root         731  0.1  2.6 1877248 52472 ?       Ssl  19:06   0:02 /usr/bin/containerd


=================================================================
                     Akhir Laporan
=================================================================
```