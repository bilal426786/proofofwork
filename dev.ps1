# Development startup script for Windows
# Starts backends in Docker, opens instructions for frontends

Write-Host ""
Write-Host "  Starting Development Environment" -ForegroundColor Yellow
Write-Host ""

# Start only backend services (no Next.js containers in dev)
Write-Host "Starting Laravel backends + MySQL in Docker..." -ForegroundColor Cyan
docker compose up -d backend-app1 backend-app2 nginx-app1 nginx-app2 mysql-app1 mysql-app2

Write-Host ""
Write-Host "  Backends are running:" -ForegroundColor Green
Write-Host "  API 1  ->  http://localhost:8001/api/health"
Write-Host "  API 2  ->  http://localhost:8002/api/health"
Write-Host ""
Write-Host "  Now open two more terminals for the frontends:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Terminal 2:" -ForegroundColor Cyan
Write-Host "    cd apps\frontend-app1"
Write-Host "    npm install"
Write-Host "    npm run dev"
Write-Host "    -> http://localhost:3000"
Write-Host ""
Write-Host "  Terminal 3:" -ForegroundColor Cyan
Write-Host "    cd apps\frontend-app2"
Write-Host "    npm install"
Write-Host "    npm run dev"
Write-Host "    -> http://localhost:3001"
Write-Host ""
Write-Host "  Edit PHP files in apps\backend-app1 or apps\backend-app2" -ForegroundColor DarkGray
Write-Host "  Changes reflect instantly (volume-mounted into Docker)" -ForegroundColor DarkGray
Write-Host ""
