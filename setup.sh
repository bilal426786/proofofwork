#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🚀 Starting Monorepo Setup...${NC}"

# Build and start all services
docker compose up -d --build

echo -e "${CYAN}⏳ Waiting for MySQL to become healthy...${NC}"
for i in $(seq 1 30); do
    if docker compose exec mysql-app1 mysqladmin ping -h localhost -u root -prootsecret --silent 2>/dev/null; then
        echo -e "${GREEN}✓ MySQL App1 ready${NC}"
        break
    fi
    sleep 2
done

for i in $(seq 1 30); do
    if docker compose exec mysql-app2 mysqladmin ping -h localhost -u root -prootsecret --silent 2>/dev/null; then
        echo -e "${GREEN}✓ MySQL App2 ready${NC}"
        break
    fi
    sleep 2
done

echo -e "${CYAN}🔑 Generating Laravel app keys...${NC}"
docker compose exec backend-app1 php artisan key:generate --force
docker compose exec backend-app2 php artisan key:generate --force

echo -e "${CYAN}🗃️  Running migrations...${NC}"
docker compose exec backend-app1 php artisan migrate --force
docker compose exec backend-app2 php artisan migrate --force

echo -e "${CYAN}🌱 Running seeders...${NC}"
docker compose exec backend-app1 php artisan db:seed --force
docker compose exec backend-app2 php artisan db:seed --force

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       ✅  Monorepo is Ready!              ║${NC}"
echo -e "${GREEN}╠═══════════════════════════════════════════╣${NC}"
echo -e "${GREEN}║  Frontend App 1   http://localhost:3000   ║${NC}"
echo -e "${GREEN}║  Frontend App 2   http://localhost:3001   ║${NC}"
echo -e "${GREEN}║  Backend API 1    http://localhost:8001   ║${NC}"
echo -e "${GREEN}║  Backend API 2    http://localhost:8002   ║${NC}"
echo -e "${GREEN}║  MySQL App1       localhost:3307          ║${NC}"
echo -e "${GREEN}║  MySQL App2       localhost:3308          ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
