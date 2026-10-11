@echo off
title Surtr Downloader
setlocal EnableDelayedExpansion
cd /d "%~dp0"

echo ========================================
echo   Surtr Downloader
echo ========================================
echo.
echo Looking for the latest Surtr release...
echo.

:: Get the latest release info from the GitHub API
set "RELEASE_INFO="
for /f "usebackq delims=" %%i in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $r = Invoke-RestMethod -Uri 'https://api.github.com/repos/Luisete2105/bo3-surtr/releases/latest' -Headers @{ 'User-Agent' = 'Surtr-Downloader' }; $asset = $r.assets | Where-Object { $_.name -like 'Surtr_*.zip' } | Select-Object -First 1; if ($asset) { Write-Output ($asset.name + '|' + $asset.browser_download_url) } else { Write-Output '' } } catch { Write-Output 'API_ERROR' }"`) do set "RELEASE_INFO=%%i"

if "%RELEASE_INFO%"=="API_ERROR" goto :error_api
if "%RELEASE_INFO%"=="" goto :error_no_asset

:: Split the zip name and download URL
for /f "tokens=1,* delims=|" %%a in ("%RELEASE_INFO%") do (
    set "ZIP_NAME=%%a"
    set "ZIP_URL=%%b"
)

:: The destination folder is the zip name without the ".zip" extension
set "DEST_FOLDER=%ZIP_NAME:.zip=%"

echo Found: %ZIP_NAME%
echo.
echo Downloading %ZIP_NAME%...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%ZIP_NAME%' -UseBasicParsing"

if not exist "%ZIP_NAME%" goto :error_download

echo.
echo Extracting into "%DEST_FOLDER%"...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%ZIP_NAME%' -DestinationPath '%DEST_FOLDER%' -Force"

if not exist "%DEST_FOLDER%\" goto :error_extract

echo.
echo Done! Latest Surtr downloaded and extracted to: "%DEST_FOLDER%"
pause
exit /b 0

:error_api
echo.
echo Could not reach the GitHub API. Check your internet connection and try again.
pause
exit /b 1

:error_no_asset
echo.
echo The latest release has no 'Surtr_*.zip' file to download.
pause
exit /b 1

:error_download
echo.
echo The download failed.
pause
exit /b 1

:error_extract
echo.
echo The extraction failed.
pause
exit /b 1