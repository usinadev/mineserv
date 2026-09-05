#!/bin/bash
# Script de backup do servidor Minecraft

set -e

# Configurações
BACKUP_DIR="/backups"
DATA_DIR="/data"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="minecraft_backup_${DATE}.tar.gz"
MAX_BACKUPS=7

echo "=== Iniciando Backup do Servidor Minecraft ==="
echo "Data: $(date)"
echo "Backup: ${BACKUP_NAME}"

# Criar diretório de backup se não existir
mkdir -p ${BACKUP_DIR}

# Criar backup
echo "Criando arquivo de backup..."
tar -czf ${BACKUP_DIR}/${BACKUP_NAME} -C ${DATA_DIR} .

# Manter apenas os últimos X backups
echo "Limpando backups antigos (mantendo ${MAX_BACKUPS} mais recentes)..."
cd ${BACKUP_DIR}
ls -t minecraft_backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm --

echo "Backup concluído com sucesso!"
echo "Arquivo: ${BACKUP_DIR}/${BACKUP_NAME}"
echo "Espaço disponível: $(df -h ${BACKUP_DIR} | tail -1 | awk '{print $4}')"
