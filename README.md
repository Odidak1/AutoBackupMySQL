# BackupMySQL V1.3

BackupMySQL adalah skrip bash yang digunakan untuk membackup database MySQL/MariaDB dan mengunggah hasil backup ke Google Drive menggunakan [Rclone](https://rclone.org/). Skrip ini juga dapat mengirimkan notifikasi status backup ke Discord melalui webhook.

## Fitur:
- Backup database MySQL ke file SQL.
- Mengunggah backup ke Google Drive secara otomatis.
- Mengirimkan notifikasi ke Discord dengan status backup (opsional).
- Dapat dijalankan secara otomatis menggunakan cron.

## Prasyarat:
- VPS/Server dengan akses root.
- Rclone terinstal dan dikonfigurasi.
- Webhook Discord (opsional, jika tidak diatur, notifikasi tidak akan dikirim).

## Panduan Instalasi

### 1. **Upload Skrip**
   Upload skrip `BackupMySQL.sh` ke direktori root server/VPS Anda (atau direktori pilihan lain).

### 2. **Instalasi Dependensi**
   Instal dependensi yang dibutuhkan oleh skrip ini dengan menjalankan perintah berikut:
   ```bash
   sudo apt-get install curl mysql-client
   ```

### 3. **Install & Setup Rclone**
   Instal rclone menggunakan perintah berikut:
   ```bash
   curl https://rclone.org/install.sh | sudo bash
   ```

   Setelah itu, konfigurasikan rclone dengan menjalankan:
   ```bash
   rclone config
   ```

   Ikuti langkah-langkah konfigurasi yang ditunjukkan di layar untuk menghubungkan Google Drive Anda ke rclone.

### 4. **Ubah Konfigurasi Skrip**
   Buka file `BackupMySQL.sh` menggunakan text editor (seperti `nano` atau `vim`) dan sesuaikan pengaturan berikut:
   
   - **`RCLONE_REMOTE_NAME`**: Nama remote rclone yang Anda konfigurasikan.
   - **`GDRIVE_DIR`**: Nama folder di Google Drive tempat backup akan disimpan.
   - **`WEBHOOK_URL`**: URL webhook Discord (jika diinginkan).
   - **`DB_HOST`**: Host database MySQL.
   - **`DB_USER`**: Pengguna database MySQL.
   - **`DB_PASS`**: Password pengguna database MySQL.
   - **`DB_NAME`**: Nama database MySQL yang akan dibackup.

### 5. **Beri Izin Eksekusi Skrip**
   Ubah izin file agar skrip dapat dieksekusi:
   ```bash
   chmod +x /root/BackupMySQL.sh
   ```

### 6. **Jalankan Skrip**
   Untuk menjalankan skrip secara manual, ketik:
   ```bash
   bash /root/BackupMySQL.sh
   ```

### 7. **Jalankan Skrip Secara Otomatis dengan Crontab**
   Untuk menjalankan skrip secara otomatis pada waktu tertentu, Anda bisa menggunakan cron. Tambahkan jadwal ke crontab dengan mengetik:
   ```bash
   crontab -e
   ```

   Lalu masukkan baris berikut untuk menjalankan skrip setiap hari pada pukul 00:00 dan 12:00:
   ```bash
   0 0,12 * * * bash /root/BackupMySQL.sh
   ```

   Simpan dan tutup editor.

## Screenshot

![Screenshot](Screenshot_20240820-071938.png)
