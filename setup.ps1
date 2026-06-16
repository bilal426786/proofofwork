# Monorepo Setup Script for Windows PowerShell
# Run with: .\setup.ps1

$ErrorActionPreference = "Stop"

function Write-Step($msg) {
    Write-Host "`n$msg" -ForegroundColor Cyan
}

function Write-OK($msg) {
    Write-Host "  OK  $msg" -ForegroundColor Green
}

Write-Host ""
Write-Host "  Monorepo Setup" -ForegroundColor Yellow
Write-Host "  Next.js x2 + Laravel x2 + Docker Compose" -ForegroundColor DarkGray
Write-Host ""

# ── Build & start ──────────────────────────────────────────
Write-Step "Building and starting all containers..."
docker compose up -d --build
if ($LASTEXITCODE -ne 0) { Write-Host "docker compose failed" -ForegroundColor Red; exit 1 }

# ── Wait for MySQL ─────────────────────────────────────────
Write-Step "Waiting for MySQL to become healthy (this takes ~20s)..."

foreach ($db in @("mysql-app1", "mysql-app2")) {
    $ready = $false
    for ($i = 1; $i -le 40; $i++) {
        $result = docker compose exec $db mysqladmin ping -h localhost -u root -prootsecret --silent 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-OK "$db is ready"
            $ready = $true
            break
        }
        Write-Host "  ... waiting for $db ($i/40)" -ForegroundColor DarkGray
        Start-Sleep -Seconds 3
    }
    if (-not $ready) {
        Write-Host "$db did not become ready in time" -ForegroundColor Red
        exit 1
    }
}

# ── Laravel app keys ───────────────────────────────────────
Write-Step "Generating Laravel app keys..."
docker compose exec backend-app1 php artisan key:generate --force
Write-OK "backend-app1 key generated"
docker compose exec backend-app2 php artisan key:generate --force
Write-OK "backend-app2 key generated"

# ── Migrations ─────────────────────────────────────────────
Write-Step "Running database migrations..."
docker compose exec backend-app1 php artisan migrate --force
Write-OK "backend-app1 migrated"
docker compose exec backend-app2 php artisan migrate --force
Write-OK "backend-app2 migrated"

# ── Seeders ────────────────────────────────────────────────
Write-Step "Seeding test data..."
docker compose exec backend-app1 php artisan db:seed --force
Write-OK "backend-app1 seeded"
docker compose exec backend-app2 php artisan db:seed --force
Write-OK "backend-app2 seeded"

# ── Done ───────────────────────────────────────────────────
Write-Host ""
Write-Host "  Monorepo is ready!" -ForegroundColor Green
Write-Host ""
Write-Host "  Frontend App 1    http://localhost:3000" -ForegroundColor White
Write-Host "  Frontend App 2    http://localhost:3001" -ForegroundColor White
Write-Host "  Backend API 1     http://localhost:8001/api/health" -ForegroundColor White
Write-Host "  Backend API 2     http://localhost:8002/api/health" -ForegroundColor White
Write-Host "  MySQL App 1       localhost:3307" -ForegroundColor DarkGray
Write-Host "  MySQL App 2       localhost:3308" -ForegroundColor DarkGray
Write-Host ""
