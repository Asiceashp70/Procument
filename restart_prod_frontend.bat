@echo off
title Restart Production Frontend (port 3000)
echo ===========================================
echo Restarting: prod-frontend (port 3000)
echo ===========================================
echo.

REM Kill process on port 3000
echo [1] Stopping old process on port 3000...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3000 " ^| findstr "LISTENING"') do (
    echo Killing PID: %%a
    taskkill /F /PID %%a 2>nul
)

echo.
echo [2] Waiting for PM2 to restart...
timeout /t 10 /nobreak

echo.
echo [3] Current port 3000 status:
netstat -ano | findstr ":3000"

echo.
echo Done! If port 3000 is listening again, the new build is active.
echo.
pause
