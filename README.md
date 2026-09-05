# Minecraft Server Dockerized

Servidor dedicado de Minecraft empacotado em Docker e pronto para hospedagem no Render.

## 🎮 Características

- ✅ Baseado em imagem oficial itzg/minecraft-server
- ✅ Suporte a Paper MC (melhor performance que Vanilla)
- ✅ Configurações otimizadas para produção
- ✅ Scripts de backup e restore
- ✅ Configuração para Render.com
- ✅ Docker Compose para desenvolvimento local
- ✅ Persistência de dados via volumes

## 📋 Pré-requisitos

- Docker e Docker Compose instalados
- Conta no Render.com (para deploy em produção)
- Git (para versionamento)

## 🚀 Execução Local

### 1. Clone o repositório

```bash
git clone <seu-repositorio>
cd mineserv
```

### 2. Configure as variáveis de ambiente

```bash
cp .env.example .env
# Edite o arquivo .env com suas configurações
```

### 3. Inicie o servidor

```bash
docker-compose up -d
```

### 4. Acompanhe os logs

```bash
docker-compose logs -f minecraft
```

### 5. Conecte-se ao servidor

- IP: `localhost`
- Porta: `25565`

## 🔧 Configurações

### Variáveis de Ambiente Principais

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `EULA` | Aceitação do EULA do Minecraft | `TRUE` |
| `TYPE` | Tipo de servidor (VANILLA, PAPER, etc) | `PAPER` |
| `VERSION` | Versão do Minecraft | `26.2` |
| `PAPER_CHANNEL` | Canal do Paper (default/experimental) | `default` |
| `SKIP_DOWNLOAD_DEFAULTS` | Pular download de configs padrão | `true` |
| `DIFFICULTY` | Dificuldade (peaceful, easy, normal, hard) | `normal` |
| `MAX_PLAYERS` | Número máximo de jogadores | `20` |
| `MEMORY` | Memória mínima alocada | `2G` |
| `MAX_MEMORY` | Memória máxima alocada | `4G` |
| `RCON_PASSWORD` | Senha para acesso RCON | `changeme` |

### Ajustando Configurações

Edite o arquivo `server.properties` para configurações mais detalhadas do servidor Minecraft.

## 🌐 Deploy no Render

### 1. Preparação

1. Faça fork deste repositório
2. Crie uma conta no [Render.com](https://render.com)
3. Conecte seu repositório GitHub ao Render

### 2. Criar Web Service

1. No Render, crie um novo "Web Service"
2. Selecione seu repositório
3. Render detectará automaticamente o `render.yaml`
4. Configure o tipo de serviço como "Docker"
5. Ajuste as variáveis de ambiente conforme necessário

### 3. Configurações Recomendadas

- **Tipo de Instância**: Starter ou Pro (dependendo do número de jogadores)
- **Região**: Escolha a mais próxima dos seus jogadores
- **Armazenamento**: Mínimo 10GB (recomendado 20GB+)
- **Portas**: 25565 (TCP/UDP), 25575 (TCP)

### 4. Variáveis de Ambiente no Render

Configure estas variáveis no painel do Render:

```
EULA=TRUE
TYPE=PAPER
VERSION=26.2
PAPER_CHANNEL=default
SKIP_DOWNLOAD_DEFAULTS=true
DIFFICULTY=normal
MAX_PLAYERS=20
MEMORY=2G
MAX_MEMORY=4G
RCON_PASSWORD=<senha_segura>
```

### 5. Deploy

O Render fará o deploy automaticamente após o push. O processo inclui:

1. Build da imagem Docker
2. Configuração do disco persistente
3. Inicialização do servidor
4. Atribuição de domínio público

### 6. Acessar o Servidor

Após o deploy, o Render fornecerá uma URL pública como:
- `https://minecraft-server.onrender.com`

Use o endereço do serviço (sem https://) como endereço do servidor no Minecraft.

## 💾 Backup e Restore

### Backup Manual

```bash
# Dentro do container
docker exec minecraft-server /backup.sh
```

### Restore Manual

```bash
# Listar backups disponíveis
docker exec minecraft-server ls -lh /backups/

# Restaurar backup específico
docker exec minecraft-server /restore.sh minecraft_backup_20240105_120000.tar.gz
```

### Backup Automático

Para backups automáticos, você pode usar o cron do host:

```bash
# Adicionar ao crontab do host
0 2 * * * cd /path/to/mineserv && docker-compose exec minecraft-server /backup.sh
```

## 🛠️ Comandos Úteis

### Docker Compose

```bash
# Iniciar servidor
docker-compose up -d

# Parar servidor
docker-compose down

# Reiniciar servidor
docker-compose restart

# Ver logs
docker-compose logs -f minecraft

# Acessar console do servidor
docker-compose exec minecraft-screen rcon-cli

# Atualizar servidor
docker-compose pull
docker-compose up -d
```

### Gerenciamento de Plugins (Paper)

```bash
# Entrar no container
docker-compose exec minecraft bash

# Instalar plugin
cd /data/plugins
wget <url-do-plugin>

# Reiniciar para aplicar
docker-compose restart
```

## 🔒 Segurança

1. **Altere a senha do RCON** nos arquivos de configuração
2. **Use ONLINE_MODE=true** se tiver autenticação Mojang
3. **Configure whitelist** para servidores privados
4. **Use HTTPS** para o painel do Render
5. **Configure firewall** no host se necessário

## 📊 Monitoramento

### Métricas Disponíveis

- Uso de CPU
- Uso de memória
- Uso de disco
- Número de jogadores conectados
- TPS (Ticks Per Second)

### Acesso RCON

```bash
docker-compose exec minecraft-screen rcon-cli
```

## 🐛 Troubleshooting

### Servidor não inicia

```bash
# Ver logs detalhados
docker-compose logs minecraft

# Verificar recursos disponíveis
docker stats
```

### Problemas de performance

- Aumente `MEMORY` e `MAX_MEMORY`
- Reduza `VIEW_DISTANCE` e `SIMULATION_DISTANCE`
- Use plugins de otimização (Spark, etc.)

### Dados perdidos após reinício

- Verifique se o volume está montado corretamente
- No Render, verifique o disco persistente
- Verifique se o backup automático está funcionando

## 📚 Recursos Adicionais

- [Documentação itzg/minecraft-server](https://github.com/itzg/docker-minecraft-server)
- [Documentação Paper MC](https://docs.papermc.io/)
- [Documentação Render](https://render.com/docs)
- [Wiki do Minecraft](https://minecraft.wiki/)

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abrir um Pull Request

## 📄 Licença

Este projeto é fornecido como está. O Minecraft é propriedade da Mojang Studios.

## ⚠️ Aviso Importante

- Este servidor requer aceitação do EULA do Minecraft
- Use apenas para fins educacionais ou em conformidade com os termos de serviço da Mojang
- Mantenha backups regulares dos dados do mundo
- Monitore os custos de hospedagem no Render

## 📞 Suporte

Para problemas específicos:
- Render: [Render Support](https://render.com/support)
- Docker: [Docker Documentation](https://docs.docker.com/)
- Minecraft: [Minecraft Help](https://help.minecraft.net/)
