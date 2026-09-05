# Início Rápido - Minecraft Server

## 🚀 Teste Local (5 minutos)

### 1. Iniciar o servidor
```bash
docker-compose up -d
```

### 2. Verificar logs
```bash
docker-compose logs -f minecraft
```

### 3. Conectar-se ao servidor
- **Endereço:** `localhost`
- **Porta:** `25565`

### 4. Parar o servidor
```bash
docker-compose down
```

## 🌐 Deploy no Render (10 minutos)

### 1. Push para GitHub
```bash
git add .
git commit -m "Adicionando servidor Minecraft"
git push origin main
```

### 2. Criar serviço no Render
1. Acesse [dashboard.render.com](https://dashboard.render.com)
2. "New +" → "Web Service"
3. Conecte seu repositório
4. Render detectará o `render.yaml` automaticamente
5. Configure variáveis de ambiente (se necessário)
6. "Create Web Service"

### 3. Aguardar deploy
- O processo leva 5-10 minutos
- Verifique os logs no painel do Render
- O servidor estará pronto quando mostrar "Done!"

### 4. Conectar ao servidor
- Use a URL do serviço Render como endereço
- Exemplo: `minecraft-server.onrender.com`
- Porta: `25565`

## ⚙️ Configurações Rápidas

### Alterar número de jogadores
Edite `docker-compose.yml` ou variável `MAX_PLAYERS` no Render:
```yaml
- MAX_PLAYERS=50
```

### Alterar dificuldade
```yaml
- DIFFICULTY=hard
```

### Alterar versão do Minecraft
```yaml
- VERSION=1.20.4
```

### Aumentar memória
```yaml
- MEMORY=4G
- MAX_MEMORY=8G
```

## 🛠️ Comandos Úteis

### Ver status do servidor
```bash
docker-compose ps
```

### Reiniciar servidor
```bash
docker-compose restart
```

### Backup manual
```bash
docker exec minecraft-server /backup.sh
```

### Acessar console do servidor
```bash
docker-compose exec minecraft-screen rcon-cli
```

## 📚 Mais Informações

- Documentação completa: <ref_file file="C:\Projetos\mineserv\README.md" />
- Guia de deployment: <ref_file file="C:\Projetos\mineserv\DEPLOYMENT.md" />
- Configurações: <ref_file file="C:\Projetos\mineserv\server.properties" />

## ⚠️ Importante

- Certifique-se de aceitar o EULA do Minecraft
- Use senhas seguras para RCON
- Monitore os custos de hospedagem
- Faça backups regulares dos dados do mundo
