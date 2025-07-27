#!/bin/bash

# --- Variables de Configuración ---
DB_USER="wordpress_user"
DB_PASS="password" # ¡CAMBIA ESTO!
DB_NAME="wordpress_db"

# Directorio donde se guardarán las copias de seguridad
BACKUP_DIR="/home/tech/backups"

# Directorio de los archivos de WordPress
SITE_DIR="/var/www/html"

# Formato de fecha para los nombres de archivo (ej: 2023-10-27)
DATE_FORMAT=$(date +"%Y-%m-%d")

# --- Inicio del Script ---
echo "Iniciando copia de seguridad de WordPress para la fecha: $DATE_FORMAT"

# Crear el directorio de backups si no existe
mkdir -p $BACKUP_DIR

# 1. Hacer backup de la Base de Datos
echo "Realizando backup de la base de datos: $DB_NAME..."
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$DATE_FORMAT.sql
echo "Backup de la base de datos completado."

# 2. Hacer backup de los Archivos del Sitio
echo "Realizando backup de los archivos del sitio: $SITE_DIR..."
tar -czvf $BACKUP_DIR/site_backup_$DATE_FORMAT.tar.gz $SITE_DIR
echo "Backup de los archivos del sitio completado."

echo "-------------------------------------"
echo "¡Copia de seguridad finalizada con éxito!"
ls -lh $BACKUP_DIR
