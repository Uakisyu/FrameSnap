@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 2
title ※ 视频一键抽帧 · By Uakisyu ※

echo ==== 视频一键抽帧 By Uakisyu ====
echo .                              .
echo   *** 使用 FFmpeg 实现抽帧 ***
echo .                              .
echo ================================
echo.

rem 检测ffmpeg.exe是否存在
set "FFMPEG=%~dp0ffmpeg.exe"
if not exist "%FFMPEG%" (
  echo [Uak.Bat] 错误, 当前目录没有找到ffmpeg.exe文件.
  echo [Uak.Bat] 请将ffmpeg.exe放入当前运行目录.
  echo.
  pause
  exit /b 1
)

rem 让用户输入视频名称/路径
set "videopath="
set /p videopath=请输入要被抽帧的视频 (文件名或详细路径, 视频格式后缀名结尾): 
echo.

rem 判断用户输入
if "%videopath%"=="" (
  echo [Uak.Bat] 错误, 你没有输入任何内容.
  echo.
  pause
  exit /b 1
)

rem 判断用户输入的视频是否存在 
if not exist "%videopath%" (
  echo [Uak.Bat] 错误, 找不到你输入的视频文件: "%videopath%".
  pause
  exit /b 1
)

rem 取视频名称并设置为输出文件夹名
for %%F in ("%videopath%") do (
  set "name=%%~nF"
)
set "outdir=!name!"

rem 让用户输入抽帧速率
set "fps="
set /p fps=请输入抽帧速率 (每秒几张，默认 5): 

rem 判断用户输入是否为空, 如是则启用默认值
if "%fps%"=="" (
  echo.
  echo [Uak.Bat] 错误, 你没有输入任何内容, 已默认为每秒抽 5 张.
  set "fps=5"
)

rem 判断用户输入是否为纯数字, 如不是则启用默认值
for /f "delims=0123456789" %%A in ("%fps%") do (
  echo.
  echo [Uak.Bat] 错误, 你输入的速率并不是纯数字, 已默认为每秒抽 5 张.
  set "fps=5"
)

rem 为用户显示抽帧输出信息
echo.
echo [Uak.Bat] 成功, 已找到指定视频, 请确认以下输出信息:
echo.
echo 视频输入: "%videopath%"
echo 抽帧输出目录: "!outdir!"
echo 抽帧设定：每秒 !fps! 张
echo.
echo [Uak.Bat] 按任意键开始抽帧.
echo.
pause

rem 创建对应文件夹
if not exist "!outdir!" (
  mkdir "!outdir!"
)

rem 开始抽帧
ffmpeg -hide_banner -y -i "%videopath%" -vf "fps=!fps!" -q:v 2 "!outdir!\!outdir!_%%06d.jpg"

rem 显示抽帧完成后信息
cls
echo ==== 视频一键抽帧 By Uakisyu ===
echo .                             .
echo   *** 使用 FFmpeg 实现抽帧 ***
echo .                             .
echo ===============================
echo.
echo [Uak.Bat] 抽帧已完成, 所有结果已保存到本地的 "!outdir!" 文件夹.
echo.
echo [Uak.Bat] 按任意键退出脚本
pause
endlocal