#! /bin/bash

# database credentials
DB_NAME="db_crud"
DB_USER="root"
DB_PASS="rouf"
BACKUP_DIR="$HOME/backup/mysql"
DATE=$(date +%F_%H-%M)

# Website credentials
SOURCE_DIR="/var/www/simple-crud-php"
BACK_DIR="$HOME/backup/website"

# Make directory
mkdir -p "$BACKUP_DIR"
mkdir -p "$BACK_DIR"

# Backup mysql Database
mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/backup_$DATE.sql"

# Backup Website
tar -czf "$BACK_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR"

# Hapus backup database lebih dari 5
cd "$BACKUP_DIR"
ls -tp backup_*.sql | grep -v '/$' | tail -n +6 | xargs -r rm

# Hapus backup web lebih dari 5
cd "$BACK_DIR"
ls -tp backup_*.tar.gz | grep -v '/$' | tail -n +6 | xargs -r rm