@echo off
echo ============================================
echo  Blog Site Setup Script
echo ============================================
echo.

echo Step 1: Checking if Docker is installed...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not in PATH
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    echo After installing Docker, restart this script.
    pause
    exit /b 1
)
echo ✓ Docker is installed

echo.
echo Step 2: Checking if Docker is running...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)
echo ✓ Docker is running

echo.
echo Step 3: Building and starting the application...
echo This may take a few minutes on first run...
docker-compose up --build -d

if %errorlevel% neq 0 (
    echo ERROR: Failed to start the application
    echo Please check the Docker logs for more information
    pause
    exit /b 1
)

echo.
echo ============================================
echo  🎉 SUCCESS! Blog Site is now running!
echo ============================================
echo.
echo 📱 Application URL: http://localhost:3000
echo 📊 MongoDB Admin: http://localhost:8081 (if mongo-express is enabled)
echo.
echo To stop the application: docker-compose down
echo To view logs: docker-compose logs -f
echo.
echo Opening the application in your default browser...
start http://localhost:3000

echo.
echo Setup completed successfully!
pause
