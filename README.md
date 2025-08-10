# 📝 Blog Site - Full Stack CRUD Application

A modern, full-stack blog application built with Next.js, MongoDB, TypeScript, and Tailwind CSS. Includes Docker support for easy deployment and development.

## ✨ Features

- **Full CRUD Operations**: Create, Read, Update, Delete blog posts
- **Dual Database Support**: MongoDB for production, in-memory mock for development
- **Modern UI**: Responsive design with Tailwind CSS
- **Type Safety**: Built with TypeScript
- **Docker Ready**: Complete containerization with Docker Compose
- **Auto-fallback**: Automatically switches between MongoDB and mock database
- **Admin Interface**: Optional MongoDB admin panel

## 🚀 Quick Start (Recommended)

### Option 1: One-Click Setup with Docker

**Prerequisites**: Docker Desktop installed and running

#### Windows Users:
```bash
# Clone the repository
git clone https://github.com/gh0st-bit/blog-site
cd blog-site

# Run the setup script
setup.bat
```

#### Mac/Linux Users:
```bash
# Clone the repository
git clone https://github.com/gh0st-bit/blog-site
cd blog-site

# Make script executable and run
chmod +x setup.sh
./setup.sh
```

The setup script will:
- ✅ Check Docker installation
- ✅ Build and start all services
- ✅ Open the application in your browser
- ✅ Set up MongoDB with admin interface

**🎉 That's it! Your blog will be running at http://localhost:3000**

### Option 2: Manual Docker Setup

```bash
# Clone and navigate to the project
git clone https://github.com/gh0st-bit/blog-site
cd blog-site

# Start all services
docker-compose up --build

# Access the application
open http://localhost:3000
```

## 🛠️ Development Setup

### Prerequisites
- Node.js 18+ 
- npm or yarn
- MongoDB (optional - uses mock database if not available)

### Local Development
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Open http://localhost:3000
```

The application will automatically use the mock database if MongoDB is not available, so you can start developing immediately!

## 📦 NPM vs NPX - What's the Difference?

### NPM (Node Package Manager)
- **Purpose**: Package manager for installing and managing dependencies
- **Usage**: `npm install package-name` (installs packages)
- **When to use**: Installing dependencies, running scripts defined in package.json

### NPX (Node Package eXecute) 
- **Purpose**: Executes packages without installing them globally
- **Usage**: `npx create-next-app` (runs commands directly)
- **When to use**: Running one-time commands, using CLI tools

### In This Project:
```bash
# Use NPM for these commands:
npm install          # Install project dependencies
npm run dev          # Run development server
npm run build        # Build the application
npm run start        # Start production server

# Use NPX for one-time setup:
npx create-next-app@latest my-blog  # Create new Next.js project
```

## 📦 Docker Services

When using Docker Compose, the following services are available:

| Service | URL | Description |
|---------|-----|-------------|
| **Blog App** | http://localhost:3000 | Main Next.js application |
| **MongoDB** | localhost:27017 | Database server |
| **Mongo Express** | http://localhost:8081 | Database admin interface |

### Mongo Express Access
- **Username**: admin
- **Password**: admin123

## 🏗️ Project Structure

```
blog-site/
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── api/posts/         # API routes for CRUD operations
│   │   ├── globals.css        # Global styles
│   │   ├── layout.tsx         # Root layout
│   │   └── page.tsx           # Homepage
│   ├── components/            # React components
│   │   ├── PostForm.tsx       # Create/Edit post form
│   │   └── PostList.tsx       # Display posts with actions
│   └── lib/                   # Utility functions
│       ├── mongodb.ts         # MongoDB connection
│       └── mockdb.ts          # Mock database for development
├── docker-compose.yml         # Docker services configuration
├── Dockerfile                 # Container build instructions
├── setup.bat                  # Windows setup script
├── setup.sh                   # Mac/Linux setup script
└── README.md                  # This file
```

## 🔧 Configuration

### Environment Variables

Create a `.env.local` file for local development:

```env
MONGODB_URI=mongodb://localhost:27017/blog-db
```

For Docker deployment, the environment is automatically configured.

### Database Switching

The application automatically detects available databases:

1. **Production/Docker**: Uses MongoDB when `MONGODB_URI` is set
2. **Development**: Falls back to mock database if MongoDB is unavailable
3. **Hybrid**: Can switch between databases without code changes

## 📋 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run start` | Start production server |
| `npm run lint` | Run ESLint |
| `docker-compose up` | Start all Docker services |
| `docker-compose down` | Stop all Docker services |

## 🐳 Docker Commands

```bash
# Start services in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and start
docker-compose up --build

# Remove all data (reset database)
docker-compose down -v
```

## 🔍 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/posts` | Get all posts |
| `POST` | `/api/posts` | Create a new post |
| `GET` | `/api/posts/[id]` | Get a specific post |
| `PUT` | `/api/posts/[id]` | Update a specific post |
| `DELETE` | `/api/posts/[id]` | Delete a specific post |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## 🚨 Troubleshooting

### Docker Issues
- **Docker not found**: Install Docker Desktop
- **Port conflicts**: Change ports in `docker-compose.yml`
- **Build fails**: Run `docker system prune` and try again

### Application Issues
- **Can't connect to database**: App will automatically use mock database
- **Blank page**: Check console for errors, ensure development server is running
- **Delete not working**: Check browser console for error messages

### Common Solutions
```bash
# Reset everything
docker-compose down -v
docker-compose up --build

# Check logs
docker-compose logs app
docker-compose logs mongo

# Restart just the app
docker-compose restart app
```

## 📄 License

MIT License - feel free to use this project for learning and development!

## 🎯 Technologies Used

- **Frontend**: Next.js 15, React, TypeScript, Tailwind CSS
- **Backend**: Next.js API Routes
- **Database**: MongoDB with Mongoose, Mock Database for development
- **Containerization**: Docker, Docker Compose
- **Development**: ESLint, Hot Reload, Auto-fallback system

---

**🎉 Happy Coding!** If you have any questions or issues, please check the troubleshooting section or open an issue.
