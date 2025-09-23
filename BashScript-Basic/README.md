# LEARNING ABOUT BASH SCRIPT

## Apa itu bash script?

Bash scripting adalah cara untuk mengotomiisasi tugas tugas yang biasa Anda lakukan di terminal Linux.Daripada mengetik satu persatu, Anda bisa menuliskannya dalam sebuah file (Skrip) dan menjalankannya sekaligus.Ini sangat menghemat waktu dalam production

1. *Cara menjalankan bash script?* Run hello.sh file

- Berikan izin eksekusi 
```bash
chmod +x hello.sh
```
* *chmod* adalah perintah mengubah izin file
* *+x* adalah menambahkan izin eksekusi


- Jalankan Skrip yang sudah dibuat
```bash
./hello.sh
```
* *./* Memberitahu terminal untuk mencari dan menjalankan file bernama *hello.sh* di direktori saat ini.

- Jika berjalan maka akan menampilkan 
```bash
Hello, Aku pakai bash script!
```

2. Input
* Di bash script kita dapat membuat sebuah input yang nantinya skrip akan meminta input pengguna jika di jalankan.

3. Variabel
* Variabel adalah wadah untuk menyimpan data.Cara membuatnya sangat mudah.Gunakan huruf besar untuk nama variabel (konvensi).
- Gunakan huruf besar untuk nama variabel
- Tidak boleh ada spasi di antara nama variabel, tanda sama dengan *( = )*, dan nilainya.

4. Command Substitution 
* Ini adalah sebuah fitur untuk menyimpan output dari sebuah perintah ke dalam sebuah variabel

5. Kondisi (if-else)
* If-else berguna untuk membuat skrip tersebut mengambil sebuah keputusan

- Operator perbandingan angka yang umum :
* *-eq*: sama dengan (*equal*)

*  *-ne*: tidak sama dengan (*not equal*)

*  *-gt*: lebih besar dari (*greater than*)

*  *-lt*: lebih kecil dari (*less than*)

*  *-ge*: lebih besar atau sama dengan (*greater or equal*)

*  *-le*: lebih kecil atau sama dengan (*less or equal*)

6. Backup.sh
- Penjelasan kode :

* Kita menemukan folder sumber dan tujuan didalam variabel agar mudah diubah

* Kita menggunakan *command substitution* dengan perintah date untuk membuat nama file unik setiap skrip dijalankan

* Kita menggunakan kondisi *if* untuk memeriksa apakah folder tujuan sudah ada (-d berarti direktori).Jika belum ada skrip akan membuatnya.

* Perintah *tar -czf ...* adalah perintah inti yang melakukan kompresi

* Menggunakan echo untuk memberikan feedback kepada pengguna

Note :
- Sesuaikan *FOLDER_SUMBER* dan *FOLDER_TUJUAN* sesuai dengan struktur direktori saat ini


