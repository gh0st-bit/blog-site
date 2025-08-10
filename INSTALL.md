# 🚀 Quick Installation Guide

## Instant Setup (30 seconds)

### Windows
```cmd
git clone https://github.com/gh0st-bit/blog-site && cd blog-site && start.bat
```

### Mac/Linux  
```bash
git clone https://github.com/gh0st-bit/blog-site && cd blog-site && chmod +x start.sh && ./start.sh
```

### Manual (Any System)
```bash
git clone https://github.com/gh0st-bit/blog-site
cd blog-site
echo "MONGODB_URI=mongodb://mongo:27017/blog-db" > .env.docker
docker compose up --build
```

## Access Your Blog
- **Blog**: http://localhost:3000
- **Admin**: http://localhost:8081 (admin/admin123)

## Stop Services
```bash
docker compose down
```

That's it! 🎉
