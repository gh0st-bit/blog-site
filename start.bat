@echo off
echo 🚀 Blog Site One-Liner Setup for Windows
echo.

echo Creating environment files...
(
echo MONGODB_URI=mongodb://mongo:27017/blog-db
echo NODE_ENV=production
echo NEXT_PUBLIC_API_URL=http://localhost:3000
) > .env.docker

if not exist ".env.local" (
    echo MONGODB_URI=mongodb://localhost:27017/blog-db > .env.local
)
echo ✅ Environment files created

echo.
echo 🐳 Starting Docker containers...
docker-compose up --build -d

if %errorlevel%==0 (
    echo.
    echo 🎉 SUCCESS! Blog running at http://localhost:3000
    echo 📊 MongoDB Admin: http://localhost:8081 (admin/admin123)
    echo.
    start http://localhost:3000
) else (
    echo.
    echo ⚠️  Docker failed. Starting local development...
    npm install
    npm run dev
)
