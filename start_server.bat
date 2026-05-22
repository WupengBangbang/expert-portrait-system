@echo off
title Expert Portrait System - LAN Service

echo.
echo  ============================================
echo    Expert Portrait Viewer - LAN Service
echo  ============================================
echo.

:: Configure firewall rule (requires admin)
net session >nul 2>&1
if %errorlevel%==0 (
    netsh advfirewall firewall show rule name="ExpertPortrait8080" >nul 2>&1
    if errorlevel 1 (
        echo  [Config] Adding firewall rule for port 8080...
        netsh advfirewall firewall add rule name="ExpertPortrait8080" dir=in action=allow protocol=tcp localport=8080 >nul
        echo  [Done] Firewall rule added successfully.
    ) else (
        echo  [Info] Firewall rule already exists, skipping.
    )
) else (
    echo  [Notice] Not running as Administrator.
    echo           If other devices cannot connect, right-click this
    echo           file and select "Run as administrator" once.
)

echo.

:: Get local LAN IP address
set IP=unknown
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set "IP=%%a"
    goto :found
)
:found
:: Trim leading space
set IP=%IP: =%

echo  ================================================
echo.
echo   LAN Address:  http://%IP%:8080
echo.
echo   Open the address above in any browser on
echo   the same network to view the system.
echo.
echo   Press Ctrl+C to stop the server.
echo.
echo  ================================================
echo.

cd /d "%~dp0"
python -m http.server 8080 --bind 0.0.0.0
pause
