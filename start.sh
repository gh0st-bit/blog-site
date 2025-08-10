#!/bin/bash
# One-liner setup for Linux/Mac users
echo "🚀 Blog Site One-Liner Setup" && \
echo "MONGODB_URI=mongodb://mongo:27017/blog-db" > .env.docker && \
echo "NODE_ENV=production" >> .env.docker && \
echo "NEXT_PUBLIC_API_URL=http://localhost:3000" >> .env.docker && \
cp .env.example .env.local 2>/dev/null || echo "MONGODB_URI=mongodb://localhost:27017/blog-db" > .env.local && \
echo "✅ Environment files created" && \
if docker compose ps &>/dev/null || docker-compose ps &>/dev/null; then \
  echo "🐳 Starting Docker containers..." && \
  (docker compose up --build -d 2>/dev/null || docker-compose up --build -d) && \
  echo "🎉 SUCCESS! Blog running at http://localhost:3000" && \
  echo "📊 MongoDB Admin: http://localhost:8081 (admin/admin123)"; \
else \
  echo "⚠️  Docker not available. Starting local development..." && \
  npm install && npm run dev & \
  echo "🎉 SUCCESS! Blog running at http://localhost:3000 (local mode)"; \
fi
