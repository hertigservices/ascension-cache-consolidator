@echo off
rem Double-click helper for tools\install.py -- shows the plan, then asks.
rem Pass any install.py options on the command line to forward them, e.g.
rem     "Install Caches.cmd" --client "D:\Games\Ascension" --mode conquest-of-azeroth
setlocal
where python >nul 2>nul
if errorlevel 1 (
    echo Python 3 was not found on PATH. Install it from https://www.python.org/downloads/
    echo and tick "Add python.exe to PATH" in the installer, then run this again.
    pause
    exit /b 1
)
python -B "%~dp0install.py" %*
if errorlevel 1 (
    echo.
    echo install.py stopped before writing anything. Read the message above.
    pause
    exit /b 1
)
echo.
set /p GO=Write these changes into the client? Quit the game first. [y/N]
if /i not "%GO%"=="y" (
    echo Nothing written.
    pause
    exit /b 0
)
python -B "%~dp0install.py" %* --write
pause
