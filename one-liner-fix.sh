#!/bin/bash

echo "🚀 One-liner fix for the .env.docker error:"
echo

# Create the missing .env.docker file
echo "Creating .env.docker..."
echo "MONGODB_URI=mongodb://mongo:27017/blog-db" > .env.docker
echo "NODE_ENV=production" >> .env.docker
echo "NEXT_PUBLIC_API_URL=http://localhost:3000" >> .env.docker

echo "✅ Fixed! Now run: docker-compose up --build"
