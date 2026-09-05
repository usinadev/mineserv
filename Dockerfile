FROM itzg/minecraft-server:java21

# Configurações do servidor
ENV EULA=TRUE
ENV TYPE=PAPER
ENV VERSION=1.21
ENV DIFFICULTY=normal
ENV MAX_PLAYERS=20
ENV PVP=true
ENV ALLOW_NETHER=true
ENV SPAWN_PROTECTION=0
ENV ONLINE_MODE=false
ENV LEVEL_TYPE=minecraft:normal
ENV GENERATE_STRUCTURES=true
ENV SEED=

# Configurações de memória (ajuste conforme necessário)
ENV MEMORY=2G
ENV MAX_MEMORY=4G

# Configurações de performance
ENV ENABLE_RCON=true
ENV RCON_PORT=25575
ENV RCON_PASSWORD=changeme

# Expor portas necessárias
EXPOSE 25565/tcp 25565/udp 25575/tcp

# Volume para persistência dos dados do mundo
VOLUME /data

# Script de inicialização personalizado
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
