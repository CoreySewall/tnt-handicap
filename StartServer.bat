@echo off
echo Starting TnT Handicap phone server...
echo.
echo Once started, open your phone browser to:
echo   http://192.168.1.134:5255
echo.
echo Leave this window open. Press Ctrl+C to stop.
echo.
cd /d "%~dp0"
dotnet run
pause
