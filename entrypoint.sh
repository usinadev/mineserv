#!/bin/bash
set -e

echo "=== Iniciando Servidor Minecraft ==="
echo "Versão: ${VERSION:-latest}"
echo "Tipo: ${TYPE:-VANILLA}"
echo "Memória: ${MEMORY:-1G} - ${MAX_MEMORY:-2G}"
echo "Porta: 25565"
echo "===================================="

# Executar o script original da imagem itzg/minecraft-server
exec /start
