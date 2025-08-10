# 🐳 CORRECT DOCKER COMMANDS FOR FURQAN

## ❌ **WRONG Commands (Don't Use These):**
```bash
docker compose --build          # WRONG - Invalid syntax
docker compose build            # WRONG - Your system doesn't have Docker Compose V2
docker build                    # WRONG - Won't start services
```

## ✅ **CORRECT Commands for Your System:**

### 🎯 **Your System Uses Legacy docker-compose**

**PRIMARY COMMANDS:**
```bash
# Build and start everything (RECOMMENDED)
docker-compose up --build -d

# Just start (if already built)
docker-compose up -d

# Build only (without starting)
docker-compose build

# Stop everything
docker-compose down

# View logs
docker-compose logs -f

# Check status
docker-compose ps
```

**WITH SUDO (if needed):**
```bash
sudo docker-compose up --build -d
sudo docker-compose down
sudo docker-compose logs -f
```

## 🚀 **IMMEDIATE FIX:**

```bash
# Navigate to your project
cd ~/Music/blogap/blog-site

# Pull latest fixes
git pull origin main

# Use the CORRECT command
docker-compose up --build -d

# If permission denied, use sudo:
sudo docker-compose up --build -d
```

## 📋 **Complete Command Reference:**

### **Starting the Application:**
```bash
# Method 1: Build and start (recommended for first time)
docker-compose up --build -d

# Method 2: Quick start (if already built)
docker-compose up -d

# Method 3: Start with logs visible
docker-compose up --build
```

### **Stopping the Application:**
```bash
# Stop services but keep data
docker-compose down

# Stop and remove all data
docker-compose down -v
```

### **Debugging:**
```bash
# View all logs
docker-compose logs

# View logs for specific service
docker-compose logs app
docker-compose logs mongo

# Follow logs in real-time
docker-compose logs -f
```

### **Management:**
```bash
# Check what's running
docker-compose ps

# Restart specific service
docker-compose restart app

# Rebuild specific service
docker-compose build app
```

## 🔍 **For Modern Docker Systems (Not Yours):**
```bash
# If someone has Docker Compose V2:
docker compose up --build -d
docker compose down
docker compose logs -f
```

## 🎯 **Your Exact Commands:**
Since you're in `~/Music/blogap/blog-site`, run:

```bash
# Navigate to project
cd ~/Music/blogap/blog-site

# Start the blog application
docker-compose up --build -d

# Check if it's running
docker-compose ps

# View the blog
# Visit: http://localhost:3000
```

## 🛠️ **Troubleshooting:**

**If you get permission errors:**
```bash
sudo docker-compose up --build -d
```

**If ports are busy:**
```bash
docker-compose down
docker-compose up --build -d
```

**If build fails:**
```bash
docker-compose down -v
docker system prune -f
docker-compose up --build -d
```

## ✅ **Expected Result:**
```
✅ Blog: http://localhost:3000
✅ Admin: http://localhost:8081 (admin/admin123)
```

**Use `docker-compose` (with hyphen) - NOT `docker compose`!**
