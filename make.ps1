# Windows replacement for Makefile
# Usage: .\make.ps1 <command>
# Example: .\make.ps1 up

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function docker-exec($service, $cmd) {
    docker compose exec $service sh -c $cmd
}

switch ($Command) {

    # ── Docker ────────────────────────────────────────────
    "up"      { docker compose up -d --build }
    "down"    { docker compose down }
    "build"   { docker compose build --no-cache }
    "logs"    { docker compose logs -f }
    "ps"      { docker compose ps }
    "restart" { docker compose restart }

    # ── backend-app1 ──────────────────────────────────────
    "migrate-app1"  { docker compose exec backend-app1 php artisan migrate --force }
    "seed-app1"     { docker compose exec backend-app1 php artisan db:seed --force }
    "fresh-app1"    { docker compose exec backend-app1 php artisan migrate:fresh --seed --force }
    "key-app1"      { docker compose exec backend-app1 php artisan key:generate --force }
    "shell-app1"    { docker compose exec backend-app1 sh }
    "tinker-app1"   { docker compose exec backend-app1 php artisan tinker }
    "routes-app1"   { docker compose exec backend-app1 php artisan route:list }

    # ── backend-app2 ──────────────────────────────────────
    "migrate-app2"  { docker compose exec backend-app2 php artisan migrate --force }
    "seed-app2"     { docker compose exec backend-app2 php artisan db:seed --force }
    "fresh-app2"    { docker compose exec backend-app2 php artisan migrate:fresh --seed --force }
    "key-app2"      { docker compose exec backend-app2 php artisan key:generate --force }
    "shell-app2"    { docker compose exec backend-app2 sh }
    "tinker-app2"   { docker compose exec backend-app2 php artisan tinker }
    "routes-app2"   { docker compose exec backend-app2 php artisan route:list }

    # ── Setup ─────────────────────────────────────────────
    "setup" {
        Write-Host "Running full setup..." -ForegroundColor Cyan
        & "$PSScriptRoot\setup.ps1"
    }

    # ── Help ──────────────────────────────────────────────
    default {
        Write-Host ""
        Write-Host "  Usage: .\make.ps1 <command>" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  Docker" -ForegroundColor Cyan
        Write-Host "    up              Build and start all containers"
        Write-Host "    down            Stop all containers"
        Write-Host "    build           Rebuild images (no cache)"
        Write-Host "    logs            Tail all logs"
        Write-Host "    ps              List containers"
        Write-Host "    restart         Restart all containers"
        Write-Host ""
        Write-Host "  Backend App 1" -ForegroundColor Cyan
        Write-Host "    migrate-app1    Run migrations"
        Write-Host "    seed-app1       Run seeders"
        Write-Host "    fresh-app1      Fresh migrate + seed"
        Write-Host "    key-app1        Generate app key"
        Write-Host "    shell-app1      Open container shell"
        Write-Host "    tinker-app1     Open Laravel Tinker"
        Write-Host "    routes-app1     List routes"
        Write-Host ""
        Write-Host "  Backend App 2" -ForegroundColor Cyan
        Write-Host "    migrate-app2    Run migrations"
        Write-Host "    seed-app2       Run seeders"
        Write-Host "    fresh-app2      Fresh migrate + seed"
        Write-Host "    key-app2        Generate app key"
        Write-Host "    shell-app2      Open container shell"
        Write-Host "    tinker-app2     Open Laravel Tinker"
        Write-Host "    routes-app2     List routes"
        Write-Host ""
        Write-Host "  Setup" -ForegroundColor Cyan
        Write-Host "    setup           Full automated first-time setup"
        Write-Host ""
    }
}
