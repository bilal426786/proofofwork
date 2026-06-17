.PHONY: up down build logs ps help \
        migrate-app1 seed-app1 fresh-app1 key-app1 shell-app1 tinker-app1 \
        migrate-app2 seed-app2 fresh-app2 key-app2 shell-app2 \
        redis-cli redis-flush setup

## ── Docker ───────────────────────────────────────────────
up: ## Start all containers
	docker compose up -d --build

down: ## Stop all containers
	docker compose down

build: ## Rebuild all images (no cache)
	docker compose build --no-cache

logs: ## Tail all logs
	docker compose logs -f

ps: ## List running containers
	docker compose ps

restart: ## Restart all containers
	docker compose restart

## ── Redis ────────────────────────────────────────────────
redis-cli: ## Open Redis CLI
	docker compose exec redis redis-cli

redis-flush: ## Flush all Redis keys
	docker compose exec redis redis-cli FLUSHALL

redis-info: ## Show Redis info
	docker compose exec redis redis-cli INFO

## ── Laravel: backend-app1 ────────────────────────────────
migrate-app1: ## Run migrations for app1
	docker compose exec backend-app1 php artisan migrate --force

seed-app1: ## Run seeders for app1
	docker compose exec backend-app1 php artisan db:seed --force

fresh-app1: ## Fresh migrate + seed app1
	docker compose exec backend-app1 php artisan migrate:fresh --seed --force

key-app1: ## Generate app key for app1
	docker compose exec backend-app1 php artisan key:generate --force

cache-app1: ## Cache config/routes for app1
	docker compose exec backend-app1 php artisan config:cache
	docker compose exec backend-app1 php artisan route:cache

shell-app1: ## Open shell in backend-app1
	docker compose exec backend-app1 sh

tinker-app1: ## Open Laravel Tinker in app1
	docker compose exec backend-app1 php artisan tinker

## ── Laravel: backend-app2 ────────────────────────────────
migrate-app2: ## Run migrations for app2
	docker compose exec backend-app2 php artisan migrate --force

seed-app2: ## Run seeders for app2
	docker compose exec backend-app2 php artisan db:seed --force

fresh-app2: ## Fresh migrate + seed app2
	docker compose exec backend-app2 php artisan migrate:fresh --seed --force

key-app2: ## Generate app key for app2
	docker compose exec backend-app2 php artisan key:generate --force

cache-app2: ## Cache config/routes for app2
	docker compose exec backend-app2 php artisan config:cache
	docker compose exec backend-app2 php artisan route:cache

shell-app2: ## Open shell in backend-app2
	docker compose exec backend-app2 sh

## ── Setup ────────────────────────────────────────────────
setup: up ## Full setup: start → keys → migrate → seed
	@echo "⏳ Waiting for MySQL and Redis to be ready..."
	@sleep 20
	$(MAKE) key-app1
	$(MAKE) key-app2
	$(MAKE) migrate-app1
	$(MAKE) migrate-app2
	$(MAKE) seed-app1
	$(MAKE) seed-app2
	@echo ""
	@echo "✅ Monorepo is ready!"
	@echo "  Frontend App 1   →  http://localhost:3000"
	@echo "  Frontend App 2   →  http://localhost:3001"
	@echo "  Backend API 1    →  http://localhost:8001/api/health"
	@echo "  Backend API 2    →  http://localhost:8002/api/health"
	@echo "  Redis Demo API1  →  http://localhost:8001/api/redis-demo"
	@echo "  Redis Demo API2  →  http://localhost:8002/api/redis-demo"
	@echo "  Redis CLI        →  make redis-cli"

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
