@echo off
rem Start the tray app with no console window.
rem pythonw.exe is deliberate: the app has a window of its own and a tray icon,
rem and a stray black console box is the thing that makes people close it.
setlocal
cd /d "%~dp0.."
start "" pythonw.exe "%~dp0tray_app.py"
