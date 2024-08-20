#!/bin/bash

# Konfigurasi
# Koneksi database MySQL
DB_USER=""
DB_PASSWORD=""
DB_NAME=""
DB_HOST=""
# Url discord webhook
WEBHOOK_URL=""
# Nama remote rclone
RCLONE_REMOTE_NAME="NamaRemote"
# Nama folder di cloud gdrive
GDRIVE_DIR="SistemBackup/BackupMySQL"

# Konfigurasi Embed Discord
# Title
TITLE_SUKSES="Status BackupDB"
TITLE_GAGAL_UPLOAD_GDRIVE="Status BackupDB"
TITLE_GAGAL="Status BackupDB"
# Description
DESCRIPTION_SUKSES="**[✅]** Backup MySQL berhasil."
DESCRIPTION_GAGAL_UPLOAD_GDRIVE="**[❎]** Backup MySQL gagal saat upload ke Google Drive."
DESCRIPTION_GAGAL="**[❎]** Backup MySQL gagal."
# Color
COLOR_SUKSES=3066993
COLOR_GAGAL_UPLOAD_GDRIVE=15158332
COLOR_GAGAL=15158332

# Konfigurasi Lanjutan
TEMP_DIR="/tmp/BackupDB"
TIMESTAMP=$(date +"%d-%m-%Y-%H:%M")
BACKUP_FILE="$TEMP_DIR/${DB_NAME}_$TIMESTAMP.sql"

mkdir -p "$TEMP_DIR" || { echo "Gagal membuat direktori $TEMP_DIR"; exit 1; }

if mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"; then
  if rclone copy "$BACKUP_FILE" "$RCLONE_REMOTE_NAME:$GDRIVE_DIR" --progress; then
    rm "$BACKUP_FILE"
    
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{
               \"embeds\": [
                 {
                   \"title\": \"$TITLE_SUKSES\",
                   \"description\": \"$DESCRIPTION_SUKSES\",
                   \"color\": $COLOR_SUKSES
                 }
               ]
             }" \
         "$WEBHOOK_URL"
  else
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{
               \"embeds\": [
                 {
                   \"title\": \"$TITLE_GAGAL_UPLOAD_GDRIVE\",
                   \"description\": \"$DESCRIPTION_GAGAL_UPLOAD_GDRIVE\",
                   \"color\": $COLOR_GAGAL_UPLOAD_GDRIVE
                 }
               ]
             }" \
         "$WEBHOOK_URL"
  fi
else
  curl -H "Content-Type: application/json" \
       -X POST \
       -d "{
             \"embeds\": [
               {
                 \"title\": \"$TITLE_GAGAL\",
                 \"description\": \"$DESCRIPTION_GAGAL\",
                 \"color\": $COLOR_GAGAL
               }
             ]
           }" \
       "$WEBHOOK_URL"
fi

rm -r "$TEMP_DIR"