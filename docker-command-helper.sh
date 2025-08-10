#!/bin/bash

echo "🐳 Docker Command Detector"
echo "=========================="
echo

# Check what's available
if command -v docker-compose &> /dev/null; then
    echo "✅ Found: docker-compose (legacy)"
    COMPOSE_CMD="docker-compose"
    COMPOSE_TYPE="Legacy"
elif docker compose version &> /dev/null; then
    echo "✅ Found: docker compose (V2)"
    COMPOSE_CMD="docker compose"
    COMPOSE_TYPE="Modern"
else
    echo "❌ No Docker Compose found!"
    echo "Please install Docker Compose first."
    exit 1
fi

echo "System Type: $COMPOSE_TYPE"
echo "Command to use: $COMPOSE_CMD"
echo

# Test permissions
if $COMPOSE_CMD ps &> /dev/null 2>&1; then
    SUDO_PREFIX=""
    echo "✅ Docker works without sudo"
else
    SUDO_PREFIX="sudo "
    echo "⚠️  Need sudo for Docker commands"
fi

echo
echo "🎯 YOUR EXACT COMMANDS:"
echo "======================="
echo
echo "# Build and start application:"
echo "${SUDO_PREFIX}${COMPOSE_CMD} up --build -d"
echo
echo "# Stop application:"
echo "${SUDO_PREFIX}${COMPOSE_CMD} down"
echo
echo "# View logs:"
echo "${SUDO_PREFIX}${COMPOSE_CMD} logs -f"
echo
echo "# Check status:"
echo "${SUDO_PREFIX}${COMPOSE_CMD} ps"
echo

# Offer to run it
read -p "🚀 Want to start the application now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Starting blog application..."
    ${SUDO_PREFIX}${COMPOSE_CMD} up --build -d
    
    if [ $? -eq 0 ]; then
        echo
        echo "✅ SUCCESS! Application is running!"
        echo "📱 Blog: http://localhost:3000"
        echo "📊 Admin: http://localhost:8081 (admin/admin123)"
    else
        echo
        echo "❌ Failed to start. Check errors above."
    fi
else
    echo "👍 Commands shown above. Run them when ready!"
fi
