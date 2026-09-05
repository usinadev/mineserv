# Guia de Deployment no Render

## 🚀 Passo a Passo para Deploy no Render

### 1. Preparação do Repositório

1. **Certifique-se de que todos os arquivos estão commitados**
   ```bash
   git add .
   git commit -m "Preparando servidor Minecraft para deploy no Render"
   git push origin main
   ```

2. **Verifique se o render.yaml está no root do repositório**
   - O arquivo deve estar na raiz do projeto
   - Render usa este arquivo para configuração automática

### 2. Configuração no Render

#### 2.1 Criar Novo Web Service

1. Acesse [dashboard.render.com](https://dashboard.render.com)
2. Clique em "New +" → "Web Service"
3. Conecte seu repositório GitHub/GitLab
4. Selecione o repositório `mineserv`

#### 2.2 Configurações do Serviço

**Nome:** `minecraft-server` (ou outro de sua preferência)

**Tipo:** Docker

**Região:** Escolha a mais próxima dos seus jogadores
- Oregon (us-west)
- Frankfurt (eu-central)
- Singapore (ap-southeast)
- São Paulo (sa-east)

**Plano:** 
- **Starter**: Para até 10 jogadores simultâneos
- **Standard**: Para 10-20 jogadores
- **Pro**: Para 20+ jogadores

#### 2.3 Variáveis de Ambiente

Configure estas variáveis na seção "Environment Variables":

```env
EULA=TRUE
TYPE=PAPER
VERSION=26.2
PAPER_CHANNEL=default
SKIP_DOWNLOAD_DEFAULTS=true
DIFFICULTY=normal
MAX_PLAYERS=20
PVP=true
ALLOW_NETHER=true
SPAWN_PROTECTION=0
ONLINE_MODE=false
LEVEL_TYPE=minecraft:normal
GENERATE_STRUCTURES=true
MEMORY=2G
MAX_MEMORY=4G
ENABLE_RCON=true
RCON_PORT=25575
RCON_PASSWORD=senha_segura_aqui
```

#### 2.4 Configurações de Disco

1. Clique em "Advanced" → "Add Disk"
2. Configure:
   - **Nome:** `minecraft-data`
   - **Mount Path:** `/data`
   - **Size:** 10GB (mínimo recomendado: 20GB)

#### 2.5 Configurações de Rede

As portas serão configuradas automaticamente pelo `render.yaml`:
- **25565** (TCP/UDP) - Porta do jogo
- **25575** (TCP) - Porta RCON

### 3. Deploy Inicial

1. Clique em "Create Web Service"
2. Render iniciará o processo de build
3. Aguarde a conclusão (pode levar 5-10 minutos)
4. O serviço ficará disponível em uma URL como:
   - `https://minecraft-server.onrender.com`

### 4. Verificação do Deploy

1. **Verifique os logs** no painel do Render
2. **Aguarde o servidor iniciar** (procure por "Done!")
3. **Teste a conexão** usando o endereço do serviço

### 5. Conexão ao Servidor

No cliente Minecraft:
- **Endereço:** Use o endereço do serviço Render (sem https://)
- **Exemplo:** `minecraft-server.onrender.com`
- **Porta:** 25565 (padrão)

### 6. Domínio Personalizado (Opcional)

Para usar seu próprio domínio:

1. **Clique em "Domains"** no painel do serviço
2. **Adicione seu domínio personalizado**
3. **Configure DNS** conforme instruções do Render:
   ```
   A    minecraft    seu-dominio.com
   ```

### 7. Configurações Adicionais

#### 7.1 Backup Automático

O Render não tem backup automático nativo, mas você pode:

1. **Usar o script de backup** incluído
2. **Configurar cron job** externo para executar backups
3. **Usar serviços externos** para backup do disco

#### 7.2 Monitoramento

Configure alertas no Render:
- CPU > 80%
- Memória > 80%
- Disco > 90%
- Servidor inativo

### 8. Solução de Problemas

#### Servidor não inicia
- Verifique os logs no painel do Render
- Confirme que `EULA=TRUE` está configurado
- Verifique se há memória suficiente

#### Conexão falha
- Verifique se as portas estão abertas
- Confirme que o serviço está rodando
- Teste usando o IP direto do Render

#### Performance ruim
- Aumente `MEMORY` e `MAX_MEMORY`
- Reduza `MAX_PLAYERS`
- Use plano superior do Render

#### Dados perdidos
- Verifique se o disco persistente está montado
- Restore a partir de backup se disponível

### 9. Custos Estimados

**Render Starter ($7/mês):**
- CPU: 0.5 vCPU
- Memória: 512MB RAM
- Disco: 10GB
- Adequado para: 5-10 jogadores

**Render Standard ($25/mês):**
- CPU: 1 vCPU
- Memória: 2GB RAM
- Disco: 20GB
- Adequado para: 10-20 jogadores

**Render Pro ($75/mês):**
- CPU: 2 vCPU
- Memória: 4GB RAM
- Disco: 50GB
- Adequado para: 20+ jogadores

### 10. Atualizações

Para atualizar o servidor:

1. **Faça alterações no código**
2. **Commit e push** para o repositório
3. **Render fará deploy automático**
4. **Monitore os logs** durante o processo

### 11. Suporte

- **Render Support:** [support.render.com](https://support.render.com)
- **Status Page:** [status.render.com](https://status.render.com)
- **Documentation:** [render.com/docs](https://render.com/docs)

## ⚠️ Notas Importantes

1. **O Render pode ter limitações** para servidores de jogo
2. **A conexão pode ter latência** dependendo da região
3. **Fique atento aos custos** com disco e transferência
4. **Backups são sua responsabilidade**
5. **Monitore o uso de recursos** regularmente

## 🎯 Próximos Passos

Após o deploy bem-sucedido:

1. Configure as regras do servidor
2. Adicione plugins se necessário
3. Configure whitelist se for privado
4. Estabeleça rotina de backup
5. Monitore performance e custos
