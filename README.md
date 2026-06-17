# Monorepo — Full Stack Docker Setup

A production-grade monorepo with 2 Next.js frontends, 2 Laravel backends, shared Redis, isolated MySQL databases, and Nginx reverse proxies — all orchestrated with Docker Compose.

## Stack Versions

| Service     | Version       | Purpose                        |
|-------------|---------------|--------------------------------|
| Next.js     | 15.3.3        | Frontend (JavaScript)          |
| React       | 19            | UI framework                   |
| Node.js     | 22 LTS        | Next.js runtime                |
| Laravel     | 12.x          | Backend API framework          |
| PHP         | 8.4           | Laravel runtime                |
| MySQL       | 9.1           | Relational databases (×2)      |
| Redis       | 7.4           | Cache · Sessions · Queues      |
| Nginx       | 1.27 Alpine   | PHP-FPM reverse proxy (×2)     |
| Composer    | 2.8           | PHP dependency manager         |

## Services & Ports

| Container      | URL / Port                      |
|----------------|---------------------------------|
| frontend-app1  | http://localhost:3000           |
| frontend-app2  | http://localhost:3001           |
| nginx-app1     | http://localhost:8001           |
| nginx-app2     | http://localhost:8002           |
| mysql-app1     | localhost:3307                  |
| mysql-app2     | localhost:3308                  |
| redis          | localhost:6379                  |

## Quick Start

```bash
# Full setup (first time)
make setup

# Or manually:
docker compose up -d --build
sleep 20
make key-app1 key-app2 migrate-app1 migrate-app2 seed-app1 seed-app2
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
