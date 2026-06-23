@echo off
title Rebuild Production Frontend
echo ===========================================
echo Rebuilding: Production Frontend (port 3000)
echo ===========================================
echo.

cd /d C:\DailyReport\production\frontend
echo [1] Building...
call npm run build
if %errorlevel% neq 0 (
  echo [ERROR] Build failed!
  pause
  exit /b %errorlevel%
)

echo.
echo [2] Restarting PM2 prod-frontend...
call pm2 restart prod-frontend
if %errorlevel% neq 0 (
  echo [WARN] PM2 restart failed, trying by name...
  call pm2 restart all
)

echo.
echo [3] Done! Checking status...
call pm2 list

echo.
pause
