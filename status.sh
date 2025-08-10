#!/bin/bash
# Quick status check for the blog application

echo "🔍 Blog Application Status Check"
echo "================================"
echo

# Check if containers are running
if docker compose ps --format json 2>/dev/null | grep -q "running"; then
    echo "✅ Docker containers are running"
    docker compose ps --format table
    echo
    
    # Test application
    if curl -s http://localhost:3000 >/dev/null 2>&1; then
        echo "✅ Blog application is accessible at http://localhost:3000"
    else
        echo "⚠️  Blog application is not responding"
    fi
    
    # Test API
    if curl -s http://localhost:3000/api/posts >/dev/null 2>&1; then
        echo "✅ API is working at http://localhost:3000/api/posts"
    else
        echo "⚠️  API is not responding"
    fi
    
    # Test MongoDB admin
    if curl -s http://localhost:8081 >/dev/null 2>&1; then
        echo "✅ MongoDB admin is accessible at http://localhost:8081"
    else
        echo "⚠️  MongoDB admin is not responding"
    fi
    
else
    echo "❌ Docker containers are not running"
    echo "💡 To start: docker compose up -d"
fi

echo
echo "🔧 Quick Commands:"
echo "  Start:   docker compose up -d"
echo "  Stop:    docker compose down"
echo "  Logs:    docker compose logs -f"
echo "  Restart: docker compose restart"
