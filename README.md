# Monorepo — Full Stack Docker Setup

A monorepo with 14 Next.js frontends (npm workspaces, one shared root
`node_modules`), 3 Laravel backends, shared Redis, one shared MySQL engine
(3 databases), and a unified Nginx gateway — all orchestrated with Docker
Compose.

## Stack Versions

| Service     | Version       | Purpose                        |
|-------------|---------------|--------------------------------|
| Next.js     | 15.3.3        | Frontend (JavaScript)          |
| React       | 19            | UI framework                   |
| Node.js     | 22 LTS        | Next.js runtime                |
| Turborepo   | 2.x           | Monorepo task runner / pruning |
| Laravel     | 12.x          | Backend API framework          |
| PHP         | 8.4           | Laravel runtime                |
| MySQL       | 8.4           | Relational databases (×3)      |
| Redis       | 7.4           | Cache · Sessions · Queues      |
| Nginx       | 1.27 Alpine   | Unified API gateway            |

## Frontend monorepo layout

```
package.json          # workspace root — "workspaces": ["apps/frontend/*", "packages/*"]
turbo.json             # task pipeline (dev/build/lint)
packages/config/        # shared eslint/tailwind/postcss/next config — every app re-exports this
apps/frontend/<app>/    # 14 Next.js apps; each still declares its own deps,
                        # but `npm install` at the ROOT hoists them into one node_modules
docker/frontend/
  Dockerfile            # shared PRODUCTION image (turbo prune, one app per build --build-arg APP=<name>)
  Dockerfile.dev         # shared DEV image (whole workspace installed once)
```

Adding a package to one app: `npm install <pkg> -w apps/frontend/<app>` (installs
at the root, symlinked into that app). Adding a package to every app: `npm install <pkg> -w apps/frontend/*` or add it to `packages/config` if it's shared tooling.

## Services & Ports

Entry points first, then identity/admin, business apps, comms, misc — same order in dev and prod.

| App          | Port | Group           |
|--------------|------|-----------------|
| website      | 3000 | Entry point     |
| workspace    | 3001 | Entry point     |
| account      | 3002 | Identity/admin  |
| admin        | 3003 | Identity/admin  |
| superadmin   | 3004 | Identity/admin  |
| crm          | 3005 | Business        |
| finance      | 3006 | Business        |
| ecommerce    | 3007 | Business        |
| drive        | 3008 | Business        |
| approval     | 3009 | Business        |
| mail         | 3010 | Comms           |
| chats        | 3011 | Comms           |
| notification | 3012 | Comms           |
| ai           | 3013 | Misc            |

| Container       | URL / Port                      |
|-----------------|----------------------------------|
| nginx-gateway   | http://localhost:8000           |
| mysql-shared    | localhost:3306                  |
| redis           | localhost:6379                  |

## Quick Start

**Development (hot reload, one shared image + node_modules):**
```bash
make dev-up           # docker compose -f docker-compose.dev.yml up --build -d
make dev-logs app=account
make dev-down
```

**Production:**
```bash
make setup            # up -d --build, then keys + migrate + seed for idp/core/business
# Or manually:
docker compose up -d --build
sleep 20
make key-idp key-core key-business migrate-idp migrate-core migrate-business
```

## API Endpoints

```
GET /api/health      — Health check (DB + Redis status)
GET /api/info        — App & PHP info
GET /api/redis-demo  — Redis counter demo (increments each call)
GET /api/users       — List users (Redis-cached)
POST /api/users      — Create user
GET /api/users/{id}  — Get user
PUT /api/users/{id}  — Update user
DELETE /api/users/{id} — Delete user
```

## Redis

Both Laravel apps share a single Redis instance for:
- **Cache** (`CACHE_DRIVER=redis`) — user lists cached for 60s
- **Sessions** (`SESSION_DRIVER=redis`)
- **Queues** (`QUEUE_CONNECTION=redis`)

```bash
make redis-cli       # Open Redis CLI
make redis-info      # Redis server info
make redis-flush     # Flush all keys
```

## Useful Commands

```bash
make up              # Start all services
make down            # Stop all services
make logs            # Tail logs
make ps              # Container status
make fresh-app1      # Fresh migrate + seed app1
make fresh-app2      # Fresh migrate + seed app2
make shell-app1      # Shell into backend-app1
make redis-cli       # Redis CLI
```
