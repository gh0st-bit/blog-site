#!/bin/bash

echo "============================================"
echo "  Blog Site Quick Setup (Linux/Mac)"
echo "============================================"
echo

echo "🔧 Setting up Docker permissions..."

# Check if user is in docker group
if groups $USER | grep -q docker; then
    echo "✓ User is already in docker group"
    USE_SUDO=false
else
    echo "⚠️  Adding user to docker group..."
    sudo usermod -aG docker $USER
    echo "✓ User added to docker group"
    echo "💡 Note: You may need to logout/login or run 'newgrp docker' for changes to take effect"
    USE_SUDO=true
fi

echo
echo "🐳 Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo
echo "🔍 Checking Docker status..."
if systemctl is-active --quiet docker; then
    echo "✓ Docker service is running"
else
    echo "❌ Failed to start Docker service"
    exit 1
fi

echo
echo "🧪 Testing Docker access..."
if docker ps &> /dev/null; then
    echo "✓ Docker is accessible without sudo"
    DOCKER_PREFIX=""
elif sudo docker ps &> /dev/null; then
    echo "⚠️  Docker requires sudo (normal for first setup)"
    DOCKER_PREFIX="sudo "
else
    echo "❌ Docker is not accessible"
    echo "Please check Docker installation"
    exit 1
fi

echo
echo "📦 Building and starting the blog application..."
echo "This will download images and build the application (may take 5-10 minutes)..."

if [ "$USE_SUDO" = true ]; then
    echo "Using sudo for Docker commands..."
    sudo docker-compose up --build -d
else
    docker-compose up --build -d
fi

if [ $? -eq 0 ]; then
    echo
    echo "============================================"
    echo "  🎉 SUCCESS! Blog Site is now running!"
    echo "============================================"
    echo
    echo "📱 Blog Application: http://localhost:3000"
    echo "📊 Database Admin: http://localhost:8081"
    echo "   Username: admin"
    echo "   Password: admin123"
    echo
    echo "🛠️  Management Commands:"
    if [ "$USE_SUDO" = true ]; then
        echo "   Stop:  sudo docker-compose down"
        echo "   Logs:  sudo docker-compose logs -f"
        echo "   Restart: sudo docker-compose restart"
    else
        echo "   Stop:  docker-compose down"
        echo "   Logs:  docker-compose logs -f"
        echo "   Restart: docker-compose restart"
    fi
    echo
    echo "🔧 To avoid using sudo in future:"
    echo "   1. Logout and login again, OR"
    echo "   2. Run: newgrp docker"
    echo
    
    # Try to open browser
    echo "🌐 Opening blog in browser..."
    if command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:3000 &
    elif command -v gnome-open &> /dev/null; then
        gnome-open http://localhost:3000 &
    elif command -v kde-open &> /dev/null; then
        kde-open http://localhost:3000 &
    else
        echo "   Please open http://localhost:3000 in your browser"
    fi
    
    echo "✅ Setup completed successfully!"
else
    echo
    echo "❌ Failed to start the application"
    echo
    echo "🔍 Troubleshooting steps:"
    echo "1. Check Docker logs: ${DOCKER_PREFIX}docker-compose logs"
    echo "2. Ensure ports 3000, 8081, 27017 are not in use"
    echo "3. Try: ${DOCKER_PREFIX}docker-compose down && ${DOCKER_PREFIX}docker-compose up --build"
    echo "4. Check available disk space"
    exit 1
fi
