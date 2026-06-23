@echo off
setlocal

cd /d "%~dp0"
set "LOG_FILE=%~dp0reset_data_clear_stock.log"

echo.
echo ============================================================
echo  Reset procurement data and clear stock quantities
echo ============================================================
echo.
echo This will keep:
echo  - Inventory master data: Product, ProductStock, ProductUnit, Category, Unit
echo  - Suppliers: Supplier, SupplierProduct
echo  - Permission: UserPermission
echo.
echo This will clear:
echo  - PR, PO, GR, WIM, Borrow, Reservation/Issue, Convert
echo  - Project Budget, StockLot, StockTransaction, PO review/approval logs
echo  - Product.stock and ProductStock.qty will be reset to 0
echo  - BOM will be kept
echo.
echo A database backup will be created before reset.
echo.
echo This file will run reset immediately.
echo Close this window now if you do not want to reset.
timeout /t 5

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found in PATH.
  echo Please run this from an environment where node is available.
  echo [%date% %time%] ERROR: Node.js was not found in PATH.>"%LOG_FILE%"
  pause
  exit /b 1
)

echo.
echo Using Node:
node -v
echo Database:
echo %~dp0backend\prisma\prod.db
echo.
echo Running reset... please wait.
echo.

echo [%date% %time%] Starting reset>"%LOG_FILE%"
echo Project: %~dp0>>"%LOG_FILE%"
echo Database: %~dp0backend\prisma\prod.db>>"%LOG_FILE%"
node -v >>"%LOG_FILE%" 2>&1

node "%~dp0tools\reset-data-clear-stock.js" --yes > "%LOG_FILE%.tmp" 2>&1
set RESULT=%ERRORLEVEL%
type "%LOG_FILE%.tmp"
type "%LOG_FILE%.tmp" >> "%LOG_FILE%"
del "%LOG_FILE%.tmp" >nul 2>nul

echo.
if not "%RESULT%"=="0" (
  echo Reset failed. Please check the message above.
  echo See log: %LOG_FILE%
  pause
  exit /b %RESULT%
)

echo Done.
echo See log: %LOG_FILE%
pause
exit /b 0
