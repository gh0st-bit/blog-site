@echo off
echo 🔍 Blog Application Status Check
echo ================================
echo.

docker compose ps >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Docker containers are running
    docker compose ps
    echo.
    
    curl -s http://localhost:3000 >nul 2>&1
    if %errorlevel%==0 (
        echo ✅ Blog application is accessible at http://localhost:3000
    ) else (
        echo ⚠️  Blog application is not responding
    )
    
    curl -s http://localhost:3000/api/posts >nul 2>&1
    if %errorlevel%==0 (
        echo ✅ API is working at http://localhost:3000/api/posts
    ) else (
        echo ⚠️  API is not responding
    )
    
    curl -s http://localhost:8081 >nul 2>&1
    if %errorlevel%==0 (
        echo ✅ MongoDB admin is accessible at http://localhost:8081
    ) else (
        echo ⚠️  MongoDB admin is not responding
    )
    
) else (
    echo ❌ Docker containers are not running
    echo 💡 To start: docker compose up -d
)

echo.
echo 🔧 Quick Commands:
echo   Start:   docker compose up -d
echo   Stop:    docker compose down
echo   Logs:    docker compose logs -f
echo   Restart: docker compose restart
echo.
pause
