@echo off
title Start Production Servers

echo ===================================================
echo Starting Production Procurement (Production Mode)
echo ===================================================
echo.

echo Starting Backend Server...
start "Backend Prod Server" cmd /k "cd /d %~dp0backend && npm run start:prod"

echo Starting Frontend Server on port 3006...
start "Frontend Prod Server" cmd /k "cd /d %~dp0frontend && npm run start -- -p 3006"

echo.
echo Both production servers have been launched in separate windows!
echo You can close this window now.
pause
