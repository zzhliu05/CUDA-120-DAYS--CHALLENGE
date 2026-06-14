@echo off
setlocal

call "D:\vs2023\main\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 exit /b %errorlevel%

nvcc %*
exit /b %errorlevel%
