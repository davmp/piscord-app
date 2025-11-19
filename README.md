# Piscord – Chat em Tempo Real Full Stack 🚀

Aplicação inspirada em plataformas de chat, utilizando Angular no frontend, Go (com Gorilla Toolkit) no backend e MongoDB para armazenamento. Projeto avançado para mostrar integração real-time, autenticação e arquitetura escalável na prática.

## 🚩 Motivação do Projeto

Criado para aprender na prática como unir Angular, Go e MongoDB em uma aplicação real-time robusta. Ideal como showcase para recrutadores e times técnicos que buscam desenvolvedores com domínio em soluções web modernas e comunicação instantânea.

## ✨ Funcionalidades

- Autenticação básica de usuários (JWT)
- Chat em tempo real por WebSocket
- Lista de conversas e usuários online
- Persistência de mensagens, salas e notificações no MongoDB
- CRUD de usuários, mensagens, salas e notificações
- Interface responsiva e otimizada em Angular
- Backend estruturado com Gorilla Mux (Go)
- Separação entre camadas: API, sockets, serviços e modelos
- Manifestos Kubernetes para deploys automatizados
- Configuração centralizada para ambientes de desenvolvimento e produção

## 🛠️ Tecnologias Utilizadas

- **DevOps:** Kubernetes, Docker
- **Frontend:** Angular 17+, TypeScript, RxJS, Angular Material, PrimeNG
- **Backend:** Go 1.21+, Gorilla Mux/WS, Gin, Middleware customizado, WebSocket
- **Persistência:** MongoDB, Redis
- **Autenticação:** JWT (JSON Web Tokens)
- **Testes:** Go Test (backend)

## 🏗️ Estrutura

- `/clusters/production`: Configuração do ambiente para prod
- `/clusters/staging`: Configuração do ambiente para dev/hom
- `/helm/`: Helm charts para piscord-app, piscord-app-frontend, piscord-app-backend

## 🚀 Como Executar

1. Clone esse repositorio
2. Configure o ambiente e valores
3. Aplique os manifestosvia `kubectl` ou instale charts via `helm`
4. Monitore e gerencie via sua ferramenta cloud-native

## 📖 Referencias

- Frontend: [piscord-frontend](https://github.com/davmp/piscord-app-frontend)
- Backend: [piscord-backend](https://github.com/davmp/piscord-app-backend)

<!-- ## 🚀 Como Executar

Esta aplicação utiliza Docker e Docker Compose para automatizar o setup do ambiente, facilitando a reprodução por outros usuários.

### Pré-requisitos

- Docker instalado ([Get Docker](https://docs.docker.com/get-started/get-docker/))
- Docker Compose

### Passos para execução

1. Abrir o projeto:

```bash
git clone https://github.com/davmp/Piscord-Chat-App.git piscord-chat-app

# Entrar na pasta do projeto
cd piscord-chat-app
```

2. Copie `.env.example` para `.env`:

```bash
# Linux and MacOS
cp .env.example .env

# Windows (CMD)
copy .env.example .env

# Windows (PowerShell)
Copy-Item .env.example .env
```

3. IMPORTANTE: Configure o ambiente seguindo os [passos listados aqui](#-configura%C3%A7%C3%A3o-de-ambiente).

   - Preencha o `.env` com seus próprios valores (JWT secret, URLs etc.) [(Veja mais)](#configurando-as-portas)

4. Depois de configurar o ambiente, execute o seguinte comando para iniciar os serviços (frontend, backend e banco MongoDB):

```bash
docker compose up --build -d
```

5. A aplicação estará disponível por padrão em http://localhost:6786.

> Em caso de algum erro, revise a configuração do ambiente [listada aqui](#-configura%C3%A7%C3%A3o-de-ambiente).

7. Para parar os serviços:

```bash
docker compose down

# Deletar os containers e imagens criados
docker compose rm -f
```

# 🔒 Configuração de Ambiente

## Configurando as variáveis de ambiente (_.env_)

### Configurando as portas

A porta externa que você vai usar para acessar o Frontend (http://localhost:FRONTEND_PORT)

```bash
FRONTEND_PORT=6786
```

A porta interna que o Backend em Go escuta

```bash
BACKEND_PORT=8000
```

### Configurando banco de dados

Credenciais do banco de dados (USADO SOMENTE PARA INICIALIZAR O SERVIÇO MONGODB)

```bash
MONGO_ROOT_USERNAME=usuarioAdmin
MONGO_ROOT_PASSWORD=senhaSecreta123

# Nome do volume do mongo (padrão)
MONGO_VOLUME_NAME=mongo-data
```

Dados de conexão que o Backend vai usar.

Nota: 'mongodb' é o nome do serviço definido em `docker-compose.yml`.

PRECISA ser igual o usuário/senha acima.

MONGO_URI=mongodb://usuarioAdmin:senhaSecreta123@mongodb:27017

### Gerando uma chave secreta JWT

Para criar uma chave aleatória e segura para o JWT no console:

#### Usando Node.js:

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

Copie o resultado e coloque no campo `JWT_SECRET` do seu `.env`.

#### Usando OpenSSL

```bash
openssl rand -base64 32
```

Copie a saída e utilize como sua chave secreta.

## Configurando NGINX

Crie um arquivo de configuração do Nginx em `/Frontend/nginx.conf`.

Configuração padrão do Nginx:

```bash
server {
    listen 80;
    server_name localhost;

    root /usr/share/nginx/html;
    index /index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://backend:8000/api/;
        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_buffering off;

        proxy_read_timeout 86400;
        proxy_send_timeout 86400;
    }

    location /api/ws {
        proxy_pass http://backend:8000/api/ws;
        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_read_timeout 86400;
    }
}
``` -->
