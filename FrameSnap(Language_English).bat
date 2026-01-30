@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 2
title ¡ù FrameSnap ¡¤ By Uakisyu ¡ù

echo ==== FrameSnap By Uakisyu ====
echo .                           .
echo    **** Using FFmpeg  ****
echo .                           .
echo =============================
echo.

rem Check if ffmpeg.exe exists
set "FFMPEG=%~dp0ffmpeg.exe"
if not exist "%FFMPEG%" (
  echo [Uak.Bat] Error, ffmpeg.exe not found.
  echo [Uak.Bat] Place ffmpeg.exe in the current running directory.
  echo.
  pause
  exit /b 1
)

rem Ask the user to input the video name/path
set "videopath="
set /p videopath=Input video Name or Path: 
echo.

rem If user input is empty
if "%videopath%"=="" (
  echo [Uak.Bat] Error, the input is empty.
  echo.
  pause
  exit /b 1
)

rem If the video input by the user exists
if not exist "%videopath%" (
  echo [Uak.Bat] Error, video not found: "%videopath%".
  pause
  exit /b 1
)

rem Retrieve the video name and set it as the output folder name.
for %%F in ("%videopath%") do (
  set "name=%%~nF"
)
set "outdir=!name!"

rem Ask the user to input the frame rate
set "fps="
set /p fps=Input the frame rate (Frame rate per second, Default 5): 

rem If the user input is empty; if so, use the default.
if "%fps%"=="" (
  echo.
  echo [Uak.Bat] Error, the input is empty. Used default value is 5.
  set "fps=5"
)

rem if the user input is purely numeric; if not, use the default.
for /f "delims=0123456789" %%A in ("%fps%") do (
  echo.
  echo [Uak.Bat] Error, the input not a pure number. Used default value is 5.
  set "fps=5"
)

rem Display settings
echo.
echo [Uak.Bat] Confirm the settings info:
echo.
echo Video: "%videopath%"
echo Output folder: "!outdir!"
echo Frame rate£º !fps! frame per second
echo.
echo [Uak.Bat] Press Anykey to start FrameSnap.
echo.
pause

rem Create the folder
if not exist "!outdir!" (
  mkdir "!outdir!"
)

rem Run ffmpeg.exe
ffmpeg -hide_banner -y -i "%videopath%" -vf "fps=!fps!" -q:v 2 "!outdir!\!outdir!_%%06d.jpg"

rem Complete
cls
echo ==== FrameSnap By Uakisyu ====
echo .                           .
echo    **** Using FFmpeg  ****
echo .                           .
echo =============================
echo.
echo [Uak.Bat] Complete, and all results have been saved to the "!outdir!" folder.
echo.
echo [Uak.Bat] Press Anykey to exit.
pause
endlocal