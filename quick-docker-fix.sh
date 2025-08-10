#!/bin/bash

echo "🔧 Quick Docker Compose Fix"
echo "============================"
echo

# Check what's available
if command -v docker-compose &> /dev/null; then
    echo "✓ Found docker-compose (legacy version)"
    COMPOSE_CMD="docker-compose"
elif docker compose version &> /dev/null; then
    echo "✓ Found docker compose (V2)"
    COMPOSE_CMD="docker compose"
else
    echo "❌ No Docker Compose found!"
    exit 1
fi

echo "Using: $COMPOSE_CMD"
echo

# Check if we need sudo
if $COMPOSE_CMD ps &> /dev/null; then
    echo "✓ Docker Compose works without sudo"
    SUDO_PREFIX=""
else
    echo "⚠️  Need sudo for Docker Compose"
    SUDO_PREFIX="sudo "
fi

echo "Full command: ${SUDO_PREFIX}${COMPOSE_CMD}"
echo

# Run the correct command
echo "🚀 Starting the blog application..."
echo "Command: ${SUDO_PREFIX}${COMPOSE_CMD} up --build -d"
echo

${SUDO_PREFIX}${COMPOSE_CMD} up --build -d

if [ $? -eq 0 ]; then
    echo
    echo "✅ Success! Application is starting..."
    echo "📱 Blog: http://localhost:3000"
    echo "📊 Admin: http://localhost:8081 (admin/admin123)"
    echo
    echo "To stop: ${SUDO_PREFIX}${COMPOSE_CMD} down"
    echo "To view logs: ${SUDO_PREFIX}${COMPOSE_CMD} logs -f"
else
    echo
    echo "❌ Failed to start. Check the error above."
    echo "Try: ${SUDO_PREFIX}${COMPOSE_CMD} logs"
fi
