@echo off
title Build & Deploy Procurement System
echo ===========================================
echo 1. Building Backend...
echo ===========================================
cd /d C:\DailyReport\procurement\backend
call npm run build
if %errorlevel% neq 0 (
  echo [ERROR] Backend build failed!
  pause
  exit /b %errorlevel%
)

echo.
echo ===========================================
echo 2. Copying Backend dist to production...
echo ===========================================
xcopy /s /y "C:\DailyReport\procurement\backend\dist\*" "C:\DailyReport\production-procurement\backend\dist\"

echo.
echo ===========================================
echo 3. Building Frontend (in source folder)...
echo ===========================================
cd /d C:\DailyReport\procurement\frontend
call npm run build
if %errorlevel% neq 0 (
  echo [ERROR] Frontend build failed!
  pause
  exit /b %errorlevel%
)

echo.
echo ===========================================
echo 3.5 Copying Frontend build to production...
echo ===========================================
robocopy "C:\DailyReport\procurement\frontend\.next" "C:\DailyReport\production-procurement\frontend\.next" /E /PURGE /NFL /NDL /NJH /NJS /NC /NS
if %errorlevel% gtr 7 (
  echo [ERROR] Frontend copy failed!
  pause
  exit /b %errorlevel%
)

echo.
echo ===========================================
echo 4. Restarting PM2...
echo ===========================================
call pm2 restart prod-procurement-backend prod-procurement-frontend

echo.
echo Done! Press any key to close.
pause
