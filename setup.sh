#!/usr/bin/env bash
set -e

echo "🚀 Starting Monorepo Setup..."
echo ""

echo "📦 Building and starting all containers..."
docker compose up -d --build

echo ""
echo "⏳ Waiting 25s for MySQL and Redis to be healthy..."
sleep 25

echo ""
echo "🔑 Generating app keys..."
docker compose exec -T backend-app1 php artisan key:generate --force
docker compose exec -T backend-app2 php artisan key:generate --force

echo ""
echo "🗄️  Running migrations..."
docker compose exec -T backend-app1 php artisan migrate --force
docker compose exec -T backend-app2 php artisan migrate --force

echo ""
echo "🌱 Seeding databases..."
docker compose exec -T backend-app1 php artisan db:seed --force
docker compose exec -T backend-app2 php artisan db:seed --force

echo ""
echo "✅ All done! Services running at:"
echo "   Frontend App 1   →  http://localhost:3000"
echo "   Frontend App 2   →  http://localhost:3001"
echo "   Backend API 1    →  http://localhost:8001/api/health"
echo "   Backend API 2    →  http://localhost:8002/api/health"
echo "   Redis Demo       →  http://localhost:8001/api/redis-demo"
echo ""
