@echo off
title Restart PM2 Production Servers

echo ===================================================
echo Restarting Production Procurement (PM2 Production)
echo ===================================================
echo.

echo Sending restart command to pm2...
call pm2 restart prod-procurement-backend prod-procurement-frontend

echo.
echo PM2 restart command executed. You can check 'pm2 status' for details.
pause
