# 🐳 VS Code Docker Extension Integration Guide

## Quick Start with VS Code Docker Extension

### Prerequisites
1. **Docker Desktop** installed and running
2. **VS Code Docker Extension** installed (`ms-azuretools.vscode-docker`)

### Using VS Code Tasks (Recommended)

Open VS Code Command Palette (`Ctrl+Shift+P`) and run:

#### 🚀 Available Tasks:
- **Start Development Server** - `npm run dev` (local development)
- **Docker: Build and Start Blog App** - Full Docker build with logs
- **Docker: Start Blog App (Background)** - Start containers in background
- **Docker: Stop Blog App** - Stop all containers
- **Docker: View Logs** - Monitor container logs
- **Docker: Restart Services** - Restart all services
- **Test: Run PowerShell Tests** - Test local application
- **Test: Run Docker Tests** - Test Docker setup

#### 📋 To Run Tasks:
1. Press `Ctrl+Shift+P`
2. Type "Tasks: Run Task"
3. Select the desired task from the list

### Using Docker Extension Panel

#### 🎯 Docker Panel Features:
1. **Open Docker Extension** (click Docker icon in sidebar)
2. **Containers View**: See all running containers
3. **Images View**: Manage Docker images
4. **Networks View**: Monitor Docker networks
5. **Volumes View**: Manage data persistence

#### 🔧 Common Actions:
- **Right-click containers** for context menu
- **View logs** by clicking on container
- **Attach shell** for debugging
- **Stop/Start** containers with buttons

### Debug Configuration

#### 🐛 Available Debug Modes:
1. **Launch Blog App (Local)** - Debug local development
2. **Attach to Docker Container** - Debug containerized app

#### To Start Debugging:
1. Press `F5` or go to Run & Debug panel
2. Select configuration
3. Start debugging

### Testing Your Setup

#### 🧪 Method 1: VS Code Tasks
```
Ctrl+Shift+P → "Tasks: Run Task" → "Test: Run Docker Tests"
```

#### 🧪 Method 2: Terminal Commands
```powershell
# Test local development
.\test-app.ps1

# Test Docker setup
.\test-docker.ps1
```

#### 🧪 Method 3: Docker Extension
1. Open Docker extension panel
2. Start containers using tasks
3. Right-click container → "View Logs"
4. Open browser to http://localhost:3000

### Container Services

| Service | Port | Description |
|---------|------|-------------|
| **blog-app** | 3000 | Main Next.js application |
| **mongo** | 27017 | MongoDB database |
| **mongo-express** | 8081 | Database admin UI |

### Troubleshooting

#### ❌ Docker Not Found
```
Error: docker command not recognized
```
**Solution:**
1. Install Docker Desktop
2. Restart VS Code
3. Check Docker is in system PATH

#### ❌ Port Already in Use
```
Error: port 3000 already in use
```
**Solution:**
1. Stop existing containers: `Docker: Stop Blog App` task
2. Or kill process: `netstat -ano | findstr :3000`

#### ❌ Container Build Fails
```
Error: build failed
```
**Solution:**
1. Run `Docker: Stop Blog App` task
2. Clean Docker: `docker system prune`
3. Run `Docker: Build and Start Blog App` task

### Best Practices

#### 🎯 Development Workflow:
1. **Local Development**: Use "Start Development Server" task
2. **Docker Testing**: Use "Docker: Build and Start Blog App" task
3. **Production Simulation**: Use background Docker tasks

#### 🔍 Monitoring:
1. **Watch Logs**: Use "Docker: View Logs" task
2. **Container Status**: Check Docker extension panel
3. **Health Checks**: Built into containers

#### 🚀 Deployment Ready:
1. **Test locally**: Ensure all features work
2. **Test Docker**: Verify containerized version
3. **Build production**: Use optimized multi-stage Dockerfile

### VS Code Settings

The following settings are automatically configured:
- Docker extension integration
- File nesting for Docker files
- TypeScript support
- Emmet for React components

### Quick Commands Reference

```bash
# Start development server
Ctrl+Shift+P → "Tasks: Run Task" → "Start Development Server"

# Start Docker containers
Ctrl+Shift+P → "Tasks: Run Task" → "Docker: Build and Start Blog App"

# View container logs
Ctrl+Shift+P → "Tasks: Run Task" → "Docker: View Logs"

# Run tests
Ctrl+Shift+P → "Tasks: Run Task" → "Test: Run Docker Tests"

# Debug application
F5 → Select "Launch Blog App (Local)"
```

### Success Indicators

✅ **Everything Working When:**
- Docker extension shows green containers
- http://localhost:3000 loads the blog
- http://localhost:8081 shows MongoDB admin (user: admin, pass: admin123)
- Tasks run without errors
- Tests pass successfully

🎉 **You're ready to use the Docker-integrated blog application!**
