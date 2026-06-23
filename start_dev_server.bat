@echo off
title Start Development Servers

echo ===================================================
echo Starting Production Procurement (Development Mode)
echo ===================================================
echo.

echo Starting target Backend Server...
start "Backend Dev Server" cmd /k "cd /d %~dp0backend && npm run start:dev"

echo Starting target Frontend Server on port 3006...
start "Frontend Dev Server" cmd /k "cd /d %~dp0frontend && npm run dev -- -p 3006"

echo.
echo Both servers have been launched in separate windows!
echo It may take a moment for them to be ready.
echo You can close this window now.
pause
