#!/bin/bash

echo "================================================"
echo "  🔧 QUICK FIX for .env.docker missing error"
echo "================================================"
echo

echo "Creating missing .env.docker file..."
cat > .env.docker << 'EOF'
# Docker environment variables
MONGODB_URI=mongodb://mongo:27017/blog-db
NODE_ENV=production
NEXT_PUBLIC_API_URL=http://localhost:3000
EOF

echo "✅ .env.docker file created successfully!"
echo

echo "Creating .env.local for development..."
if [ ! -f ".env.local" ]; then
    cat > .env.local << 'EOF'
# Local Development Environment Variables
MONGODB_URI=mongodb://localhost:27017/blog-db
EOF
    echo "✅ .env.local file created successfully!"
else
    echo "✅ .env.local already exists"
fi

echo
echo "🚀 Now running Docker Compose..."
echo

# Check if user needs sudo for docker
if docker ps &> /dev/null; then
    echo "Running without sudo..."
    docker-compose up --build -d
else
    echo "Running with sudo..."
    sudo docker-compose up --build -d
fi

if [ $? -eq 0 ]; then
    echo
    echo "🎉 SUCCESS! Blog application is starting up..."
    echo
    echo "Please wait 30-60 seconds for all services to start, then visit:"
    echo "📱 Blog App: http://localhost:3000"
    echo "📊 MongoDB Admin: http://localhost:8081 (admin/admin123)"
    echo
    echo "To view logs: docker-compose logs -f"
    echo "To stop: docker-compose down"
    echo
    
    # Try to open browser
    if command -v xdg-open &> /dev/null; then
        echo "🌐 Opening blog in browser..."
        sleep 5
        xdg-open http://localhost:3000 &
    fi
    
else
    echo
    echo "❌ Still having issues. Let's try alternative approach..."
    echo
    echo "Manual commands to try:"
    echo "1. sudo docker-compose down"
    echo "2. sudo docker-compose up --build"
    echo "3. Check logs: sudo docker-compose logs"
fi
