# Docker Test Script for Blog Application
# This script tests the Docker setup using VS Code Docker extension

Write-Host "Docker Blog Application Test" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is available
Write-Host "1. Checking Docker installation..." -ForegroundColor Yellow

try {
    # Try different Docker command variations
    $dockerVersion = $null
    
    # Try docker command directly
    try {
        $dockerVersion = & docker --version 2>$null
    } catch {}
    
    # Try using full path (common Docker Desktop installation)
    if (-not $dockerVersion) {
        try {
            $dockerVersion = & "C:\Program Files\Docker\Docker\resources\bin\docker.exe" --version 2>$null
        } catch {}
    }
    
    # Try using Docker Desktop CLI
    if (-not $dockerVersion) {
        try {
            $dockerVersion = & "${env:ProgramFiles}\Docker\Docker\Docker Desktop.exe" --version 2>$null
        } catch {}
    }
    
    if ($dockerVersion) {
        Write-Host "[OK] Docker found: $dockerVersion" -ForegroundColor Green
        
        # Check Docker Compose
        Write-Host ""
        Write-Host "2. Checking Docker Compose..." -ForegroundColor Yellow
        
        try {
            # Try modern docker compose command
            $composeVersion = & docker compose version 2>$null
            if ($composeVersion) {
                Write-Host "[OK] Docker Compose found: $composeVersion" -ForegroundColor Green
                
                # Test Docker services
                Write-Host ""
                Write-Host "3. Testing Docker services..." -ForegroundColor Yellow
                
                # Stop any existing containers
                Write-Host "Stopping existing containers..." -ForegroundColor Gray
                & docker compose down 2>$null
                
                # Start services
                Write-Host "Starting blog application services..." -ForegroundColor Gray
                $startProcess = Start-Process -FilePath "docker" -ArgumentList "compose", "up", "--build", "-d" -NoNewWindow -Wait -PassThru
                
                if ($startProcess.ExitCode -eq 0) {
                    Write-Host "[OK] Docker services started successfully" -ForegroundColor Green
                    
                    # Wait for services to be ready
                    Write-Host ""
                    Write-Host "4. Waiting for services to be ready..." -ForegroundColor Yellow
                    Start-Sleep -Seconds 15
                    
                    # Test application
                    Write-Host ""
                    Write-Host "5. Testing application endpoints..." -ForegroundColor Yellow
                    
                    try {
                        $response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -TimeoutSec 30
                        if ($response.StatusCode -eq 200) {
                            Write-Host "[OK] Blog application is running at http://localhost:3000" -ForegroundColor Green
                            
                            # Test API
                            try {
                                $apiResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/posts" -Method Get -TimeoutSec 10
                                Write-Host "[OK] API is working, found $($apiResponse.Count) posts" -ForegroundColor Green
                                
                                # Test MongoDB Admin (optional)
                                try {
                                    $adminResponse = Invoke-WebRequest -Uri "http://localhost:8081" -UseBasicParsing -TimeoutSec 10
                                    if ($adminResponse.StatusCode -eq 200) {
                                        Write-Host "[OK] MongoDB Admin interface is available at http://localhost:8081" -ForegroundColor Green
                                    }
                                } catch {
                                    Write-Host "[INFO] MongoDB Admin interface not accessible (this is optional)" -ForegroundColor Gray
                                }
                                
                                Write-Host ""
                                Write-Host "SUCCESS: Docker setup is working perfectly!" -ForegroundColor Green
                                Write-Host ""
                                Write-Host "Available Services:" -ForegroundColor Cyan
                                Write-Host "- Blog App: http://localhost:3000" -ForegroundColor White
                                Write-Host "- MongoDB: localhost:27017" -ForegroundColor White
                                Write-Host "- Admin Panel: http://localhost:8081 (admin/admin123)" -ForegroundColor White
                                Write-Host ""
                                Write-Host "To stop services: docker compose down" -ForegroundColor Gray
                                
                            } catch {
                                Write-Host "[ERROR] API test failed: $($_.Exception.Message)" -ForegroundColor Red
                            }
                        }
                    } catch {
                        Write-Host "[ERROR] Application not responding: $($_.Exception.Message)" -ForegroundColor Red
                        Write-Host "Checking container logs..." -ForegroundColor Gray
                        & docker compose logs app
                    }
                } else {
                    Write-Host "[ERROR] Failed to start Docker services" -ForegroundColor Red
                    Write-Host "Checking logs..." -ForegroundColor Gray
                    & docker compose logs
                }
            } else {
                throw "Docker Compose not found"
            }
        } catch {
            Write-Host "[ERROR] Docker Compose test failed: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host ""
            Write-Host "Troubleshooting:" -ForegroundColor Yellow
            Write-Host "1. Make sure Docker Desktop is running" -ForegroundColor White
            Write-Host "2. Try: docker compose up --build" -ForegroundColor White
            Write-Host "3. Check VS Code Docker extension is installed" -ForegroundColor White
        }
    } else {
        throw "Docker not found in system PATH"
    }
} catch {
    Write-Host "[ERROR] Docker not available: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Setup Instructions:" -ForegroundColor Yellow
    Write-Host "1. Install Docker Desktop from https://docker.com" -ForegroundColor White
    Write-Host "2. Start Docker Desktop" -ForegroundColor White
    Write-Host "3. Install VS Code Docker extension" -ForegroundColor White
    Write-Host "4. Run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "Alternative: Use local development mode with 'npm run dev'" -ForegroundColor Cyan
}
