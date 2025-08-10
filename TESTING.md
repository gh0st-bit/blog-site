# Quick Setup Test

## Test Docker Setup

To test if everything works correctly:

1. **Run the setup script**:
   - Windows: Double-click `setup.bat`
   - Mac/Linux: Run `./setup.sh`

2. **Manual verification**:
   ```bash
   # Check if containers are running
   docker ps
   
   # Should show 3 containers:
   # - blog-site-app
   # - blog-site-mongo  
   # - blog-site-mongo-express
   ```

3. **Test the application**:
   - Visit http://localhost:3000
   - Create a new post
   - Edit an existing post
   - Delete a post
   - Verify changes persist after page refresh

4. **Test MongoDB admin** (optional):
   - Visit http://localhost:8081
   - Login: admin / admin123
   - Navigate to blog-db → posts collection
   - Verify your posts are stored in MongoDB

## Troubleshooting

### If setup fails:
```bash
# Clean up and retry
docker-compose down -v
docker system prune -f
docker-compose up --build
```

### If delete doesn't work:
- Check browser console (F12) for errors
- Verify the post ID is being passed correctly
- Check if MongoDB is connected (should see posts persisting after refresh)

### If MongoDB connection fails:
- App will automatically fall back to mock database
- Posts won't persist after restart, but CRUD operations will work
- This is normal for development without MongoDB

## Success Indicators

✅ **Application loads at localhost:3000**  
✅ **Can create new posts**  
✅ **Can edit existing posts**  
✅ **Can delete posts with confirmation**  
✅ **Changes persist after page refresh** (MongoDB connected)  
✅ **MongoDB admin accessible at localhost:8081** (optional)  

If all indicators pass, the setup is successful! 🎉
