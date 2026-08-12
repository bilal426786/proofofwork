.PHONY: up down build logs ps help \
        migrate-idp seed-idp fresh-idp key-idp cache-idp shell-idp tinker-idp \
        migrate-core seed-core fresh-core key-core cache-core shell-core tinker-core \
        migrate-business seed-business fresh-business key-business cache-business shell-business tinker-business \
        redis-cli redis-flush redis-info setup \
        dev-up dev-down dev-build dev-logs dev-ps

## ── Docker (production) ─────────────────────────────────────
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

## ── Docker (development, hot reload) ────────────────────────
## All 14 frontend apps share one image + one root node_modules
## (docker/frontend/Dockerfile.dev). Rebuild only after touching a
## package.json or package-lock.json; source edits hot-reload live.
dev-up: ## Start all frontend apps in dev mode (bind mount + hot reload)
	docker compose -f docker-compose.dev.yml up --build -d

dev-down: ## Stop all dev containers
	docker compose -f docker-compose.dev.yml down

dev-build: ## Rebuild the shared dev image (after changing a package.json)
	docker compose -f docker-compose.dev.yml build

dev-logs: ## Tail dev logs (e.g. make dev-logs app=account)
	docker compose -f docker-compose.dev.yml logs -f $(app)

dev-ps: ## List running dev containers
	docker compose -f docker-compose.dev.yml ps

## ── Redis ────────────────────────────────────────────────
redis-cli: ## Open Redis CLI
	docker compose exec redis redis-cli

redis-flush: ## Flush all Redis keys
	docker compose exec redis redis-cli FLUSHALL

redis-info: ## Show Redis info
	docker compose exec redis redis-cli INFO

## ── Laravel: idp ─────────────────────────────────────────
migrate-idp: ## Run migrations for idp
	docker compose exec idp php artisan migrate --force

seed-idp: ## Run seeders for idp
	docker compose exec idp php artisan db:seed --force

fresh-idp: ## Fresh migrate + seed idp
	docker compose exec idp php artisan migrate:fresh --seed --force

key-idp: ## Generate app key for idp
	docker compose exec idp php artisan key:generate --force

cache-idp: ## Cache config/routes for idp
	docker compose exec idp php artisan config:cache
	docker compose exec idp php artisan route:cache

shell-idp: ## Open shell in idp
	docker compose exec idp sh

tinker-idp: ## Open Laravel Tinker in idp
	docker compose exec idp php artisan tinker

## ── Laravel: core ────────────────────────────────────────
migrate-core: ## Run migrations for core
	docker compose exec core php artisan migrate --force

seed-core: ## Run seeders for core
	docker compose exec core php artisan db:seed --force

fresh-core: ## Fresh migrate + seed core
	docker compose exec core php artisan migrate:fresh --seed --force

key-core: ## Generate app key for core
	docker compose exec core php artisan key:generate --force

cache-core: ## Cache config/routes for core
	docker compose exec core php artisan config:cache
	docker compose exec core php artisan route:cache

shell-core: ## Open shell in core
	docker compose exec core sh

tinker-core: ## Open Laravel Tinker in core
	docker compose exec core php artisan tinker

## ── Laravel: business ────────────────────────────────────
migrate-business: ## Run migrations for business
	docker compose exec business php artisan migrate --force

seed-business: ## Run seeders for business
	docker compose exec business php artisan db:seed --force

fresh-business: ## Fresh migrate + seed business
	docker compose exec business php artisan migrate:fresh --seed --force

key-business: ## Generate app key for business
	docker compose exec business php artisan key:generate --force

cache-business: ## Cache config/routes for business
	docker compose exec business php artisan config:cache
	docker compose exec business php artisan route:cache

shell-business: ## Open shell in business
	docker compose exec business sh

tinker-business: ## Open Laravel Tinker in business
	docker compose exec business php artisan tinker

## ── Setup ────────────────────────────────────────────────
setup: up ## Full setup: start → keys → migrate → seed
	@echo "⏳ Waiting for MySQL and Redis to be ready..."
	@sleep 20
	$(MAKE) key-idp
	$(MAKE) key-core
	$(MAKE) key-business
	$(MAKE) migrate-idp
	$(MAKE) migrate-core
	$(MAKE) migrate-business
	$(MAKE) seed-idp
	$(MAKE) seed-core
	$(MAKE) seed-business
	@echo ""
	@echo "✅ Monorepo is ready!"
	@echo "  website        →  http://localhost:3000"
	@echo "  workspace      →  http://localhost:3001"
	@echo "  ... (see README for the full port table)"
	@echo "  API gateway    →  http://localhost:8000"
	@echo "  Redis CLI      →  make redis-cli"

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
