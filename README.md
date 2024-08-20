# Panduan Instalasi Skrip BackupMySQL

Skrip ini digunakan untuk membackup database MySQL dan mengunggah hasil backup ke Google Drive menggunakan rclone, serta mengirimkan notifikasi status ke Discord melalui webhook. Berikut adalah petunjuk untuk menginstal dan menjalankan skrip ini.
![Screenshot](Screenshot_20240820-071938.png)

### 1. **Upload Skrip**
   Upload skrip `BackupMySQL.sh` ke folder root server/VPS Anda.
### 2. **Instalasi Dependensi**
   Instal dependensi yang dibutuhkan skrip ini di server/VPS Anda dengan mengetik:
   `sudo apt-get install curl rclone mysql-client`
### 3. **Setup Rclone**
   Anda harus mengonfigurasi rclone di server/VPS Anda. Ikuti panduan [rclone configuration](https://rclone.org/docs/) untuk menyiapkan remote dengan nama yang sesuai dengan konfigurasi.
### 4. **Ubah Konfigurasi**
   Edit konfigurasi skrip BackupData.sh untuk menyesuaikan konfigurasi
### 5. **Beri Izin Eksekusi**
   Ubah izin file agar skrip dapat dijalankan:
   `chmod +x /root/BackupMySQL.sh`
### 6. **Jalankan Skrip**
   Jalankan skrip dengan mengetik perintah:
   `bash /root/BackupMySQL.sh`
### 7. **Setup Crontab**
   Untuk menjalankan skrip secara otomatis, ketik `crontab -e` lalu masukkan baris berikut:
   `0 0,12 * * * bash /root/BackupMySQL.sh`