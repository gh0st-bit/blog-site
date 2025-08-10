#!/bin/bash

echo "============================================"
echo "  Blog Site Setup Script"
echo "============================================"
echo

echo "Step 1: Setting up environment files..."
# Create .env.local if it doesn't exist
if [ ! -f ".env.local" ]; then
    echo "Creating .env.local from template..."
    cp .env.example .env.local
    echo "✓ .env.local created"
else
    echo "✓ .env.local already exists"
fi

# Create .env.docker if it doesn't exist
if [ ! -f ".env.docker" ]; then
    echo "Creating missing .env.docker file..."
    cat > .env.docker << 'EOF'
# Docker environment variables
MONGODB_URI=mongodb://mongo:27017/blog-db
NODE_ENV=production
NEXT_PUBLIC_API_URL=http://localhost:3000
EOF
    echo "✓ .env.docker created"
else
    echo "✓ .env.docker already exists"
fi

echo
echo "Step 2: Checking if Docker is installed..."
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    echo "Please install Docker from: https://www.docker.com/get-docker"
    echo "After installing Docker, restart this script."
    exit 1
fi
echo "✓ Docker is installed"

echo
echo "Step 3: Checking if Docker is running..."

# Try different methods to check if Docker is running
DOCKER_RUNNING=false

# Method 1: Try docker ps without sudo
if docker ps &> /dev/null; then
    DOCKER_RUNNING=true
# Method 2: Try with sudo if user isn't in docker group
elif sudo docker ps &> /dev/null; then
    echo "⚠️  Note: Docker requires sudo. Adding current user to docker group is recommended."
    echo "   Run: sudo usermod -aG docker $USER && newgrp docker"
    DOCKER_RUNNING=true
    DOCKER_CMD="sudo docker"
    COMPOSE_CMD="sudo docker-compose"
# Method 3: Check if Docker daemon is running via systemctl
elif systemctl is-active --quiet docker; then
    echo "⚠️  Docker daemon is running but not accessible. Checking permissions..."
    if groups $USER | grep -q docker; then
        echo "   User is in docker group. Try logging out and back in."
    else
        echo "   Adding user to docker group..."
        sudo usermod -aG docker $USER
        echo "   Please run: newgrp docker"
        echo "   Or logout and login again, then re-run this script."
    fi
    DOCKER_RUNNING=true
    DOCKER_CMD="sudo docker"
    COMPOSE_CMD="sudo docker-compose"
fi

if [ "$DOCKER_RUNNING" = false ]; then
    echo "ERROR: Docker is not running"
    echo "Please start Docker with: sudo systemctl start docker"
    echo "Or check if Docker Desktop is running (if using Docker Desktop)"
    exit 1
fi

# Set default commands if not set
DOCKER_CMD=${DOCKER_CMD:-docker}
COMPOSE_CMD=${COMPOSE_CMD:-docker-compose}

echo "✓ Docker is running"

echo
echo "Step 4: Building and starting the application..."
echo "This may take a few minutes on first run..."

# Use the appropriate command based on what was detected
if [ "$COMPOSE_CMD" = "sudo docker-compose" ]; then
    echo "Using sudo for docker-compose commands..."
    sudo docker-compose up --build -d
else
    docker-compose up --build -d
fi

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to start the application"
    echo "Please check the Docker logs for more information"
    exit 1
fi

echo
echo "============================================"
echo "  🎉 SUCCESS! Blog Site is now running!"
echo "============================================"
echo
echo "📱 Application URL: http://localhost:3000"
echo "📊 MongoDB Admin: http://localhost:8081 (if mongo-express is enabled)"
echo
if [ "$COMPOSE_CMD" = "sudo docker-compose" ]; then
    echo "To stop the application: sudo docker-compose down"
    echo "To view logs: sudo docker-compose logs -f"
else
    echo "To stop the application: docker-compose down"
    echo "To view logs: docker-compose logs -f"
fi
echo
echo "Opening the application in your default browser..."
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
fi

echo
echo "Setup completed successfully!"
