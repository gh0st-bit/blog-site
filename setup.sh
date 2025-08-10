#!/bin/bash

echo "============================================"
echo "  Blog Site Setup Script"
echo "============================================"
echo

echo "Step 1: Checking if Docker is installed..."
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    echo "Please install Docker from: https://www.docker.com/get-docker"
    echo "After installing Docker, restart this script."
    exit 1
fi
echo "✓ Docker is installed"

echo
echo "Step 2: Checking if Docker is running..."
if ! docker ps &> /dev/null; then
    echo "ERROR: Docker is not running"
    echo "Please start Docker and try again."
    exit 1
fi
echo "✓ Docker is running"

echo
echo "Step 3: Building and starting the application..."
echo "This may take a few minutes on first run..."
docker-compose up --build -d

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
echo "To stop the application: docker-compose down"
echo "To view logs: docker-compose logs -f"
echo
echo "Opening the application in your default browser..."
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
fi

echo
echo "Setup completed successfully!"
