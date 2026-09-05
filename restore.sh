#!/bin/bash
# Script de restore do servidor Minecraft

set -e

# Configurações
BACKUP_DIR="/backups"
DATA_DIR="/data"

if [ -z "$1" ]; then
    echo "Uso: $0 <backup_file>"
    echo "Exemplo: $0 minecraft_backup_20240105_120000.tar.gz"
    echo ""
    echo "Backups disponíveis:"
    ls -lh ${BACKUP_DIR}/minecraft_backup_*.tar.gz 2>/dev/null || echo "Nenhum backup encontrado"
    exit 1
fi

BACKUP_FILE="${BACKUP_DIR}/$1"

if [ ! -f "${BACKUP_FILE}" ]; then
    echo "Erro: Arquivo de backup não encontrado: ${BACKUP_FILE}"
    exit 1
fi

echo "=== Restaurando Backup do Servidor Minecraft ==="
echo "Backup: ${BACKUP_FILE}"
echo "Data: $(date)"
echo "⚠️  AVISO: Isso irá substituir todos os dados atuais!"
echo ""

read -p "Deseja continuar? (s/N): " confirm
if [[ ! $confirm =~ ^[Ss]$ ]]; then
    echo "Operação cancelada."
    exit 0
fi

echo "Parando o servidor..."
# Comando para parar o servidor pode variar dependendo da implementação
# Aqui assumimos que o servidor está rodando via docker compose
# docker-compose down

echo "Restaurando backup..."
rm -rf ${DATA_DIR}/*
tar -xzf ${BACKUP_FILE} -C ${DATA_DIR}

echo "Backup restaurado com sucesso!"
echo "Iniciando o servidor..."
# docker-compose up -d
