#!/bin/bash

echo "============================================"
echo "  Docker Troubleshooting for Linux"
echo "============================================"
echo

echo "🔍 Diagnosing Docker setup..."
echo

# Check 1: Docker installation
echo "1. Checking Docker installation..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version 2>/dev/null || echo "Version check failed")
    echo "✓ Docker is installed: $DOCKER_VERSION"
else
    echo "❌ Docker is not installed"
    echo "   Install with: curl -fsSL https://get.docker.com | sh"
    exit 1
fi

echo

# Check 2: Docker service status
echo "2. Checking Docker service..."
if systemctl is-active --quiet docker; then
    echo "✓ Docker service is running"
else
    echo "⚠️  Docker service is not running"
    echo "   Starting Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker
    
    if systemctl is-active --quiet docker; then
        echo "✓ Docker service started successfully"
    else
        echo "❌ Failed to start Docker service"
        echo "   Check with: sudo systemctl status docker"
        exit 1
    fi
fi

echo

# Check 3: Docker permissions
echo "3. Checking Docker permissions..."
if docker ps &> /dev/null; then
    echo "✓ Docker is accessible without sudo"
    NEEDS_SUDO=false
else
    echo "⚠️  Docker requires sudo"
    
    if groups $USER | grep -q docker; then
        echo "   User is in docker group but needs to re-login"
        echo "   Run: newgrp docker"
        echo "   Or logout and login again"
    else
        echo "   Adding user to docker group..."
        sudo usermod -aG docker $USER
        echo "✓ User added to docker group"
        echo "   Run: newgrp docker"
        echo "   Or logout and login again"
    fi
    NEEDS_SUDO=true
fi

echo

# Check 4: Docker daemon accessibility
echo "4. Testing Docker daemon..."
if [ "$NEEDS_SUDO" = true ]; then
    if sudo docker ps &> /dev/null; then
        echo "✓ Docker daemon is accessible with sudo"
    else
        echo "❌ Docker daemon is not responding"
        echo "   Try: sudo systemctl restart docker"
        exit 1
    fi
else
    echo "✓ Docker daemon is accessible"
fi

echo

# Check 5: Docker Compose
echo "5. Checking Docker Compose..."
if command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version 2>/dev/null || echo "Version check failed")
    echo "✓ Docker Compose is installed: $COMPOSE_VERSION"
elif docker compose version &> /dev/null; then
    COMPOSE_VERSION=$(docker compose version 2>/dev/null || echo "Version check failed")
    echo "✓ Docker Compose (plugin) is available: $COMPOSE_VERSION"
else
    echo "⚠️  Docker Compose not found"
    echo "   Install with: sudo apt-get install docker-compose"
    echo "   Or use: docker compose (built-in to newer Docker versions)"
fi

echo

# Check 6: Port availability
echo "6. Checking required ports..."
PORTS=(3000 8081 27017)
for port in "${PORTS[@]}"; do
    if netstat -tuln 2>/dev/null | grep -q ":$port "; then
        echo "⚠️  Port $port is in use"
        echo "   Find process: sudo netstat -tulnp | grep :$port"
        echo "   Kill process: sudo kill -9 <PID>"
    else
        echo "✓ Port $port is available"
    fi
done

echo

# Check 7: Disk space
echo "7. Checking disk space..."
AVAILABLE=$(df /var/lib/docker 2>/dev/null | tail -1 | awk '{print $4}' || echo "0")
if [ "$AVAILABLE" -gt 1000000 ]; then  # 1GB in KB
    echo "✓ Sufficient disk space available"
else
    echo "⚠️  Low disk space in /var/lib/docker"
    echo "   Clean up: sudo docker system prune"
fi

echo

# Summary and recommendations
echo "============================================"
echo "  🎯 Recommendations"
echo "============================================"
echo

if [ "$NEEDS_SUDO" = true ]; then
    echo "🔧 Docker Permission Fix:"
    echo "   Run one of these commands then restart terminal:"
    echo "   • newgrp docker"
    echo "   • Logout and login again"
    echo "   • su - $USER"
    echo
fi

echo "🚀 Quick Start Commands:"
if [ "$NEEDS_SUDO" = true ]; then
    echo "   sudo docker-compose up --build -d"
    echo "   sudo docker-compose logs -f"
    echo "   sudo docker-compose down"
else
    echo "   docker-compose up --build -d"
    echo "   docker-compose logs -f"
    echo "   docker-compose down"
fi
echo

echo "🧪 Test Your Setup:"
echo "   ./quick-setup.sh    # Automated setup"
echo "   ./setup.sh          # Standard setup"
echo

echo "📚 Useful Commands:"
echo "   docker ps           # List running containers"
echo "   docker images       # List images"
echo "   docker system prune # Clean up unused data"
echo

echo "✅ Troubleshooting completed!"
echo "   If issues persist, check Docker documentation or restart your system."
