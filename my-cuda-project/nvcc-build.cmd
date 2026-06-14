@echo off
setlocal

call "D:\vs2023\main\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 (
    echo Failed to initialize the MSVC build environment.
    exit /b 1
)

nvcc %*
exit /b %errorlevel%
