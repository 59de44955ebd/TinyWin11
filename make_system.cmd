@echo off

cd /d %~dp0
set "CWD=%CD%"
set PATH=%CD%\tools;%PATH%

REM Config ################################################
set BASENAME=TinyWin11_22H2_English
set IMG_SIZE=4294967296
set DRIVE_LETTER=Z
REM /Config ###############################################

set "TARGET_DIR=%CWD%"
set "WINPE_DIR=%CWD%\WinPE"

set "IMG_FILE=%TARGET_DIR%\%BASENAME%.img"
set "VHD_FILE=%TARGET_DIR%\%BASENAME%.vhd"
set "VMDK_FILE=%TARGET_DIR%\vmware\%BASENAME%.vmdk"

call "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat"
cd /d "%CWD%"

REM Clean up old stuff
del /f "%IMG_FILE%" 2>nul
del /f "%VHD_FILE%" 2>nul
del /f "%VMDK_FILE%" 2>nul
rmdir /s /q "%WINPE_DIR%" 2>nul

echo.
echo ====================================
echo Creating raw image file...
echo ====================================
fsutil file createnew "%IMG_FILE%" %IMG_SIZE%

echo.
echo ====================================
echo Converting image file to VHD...
echo ====================================
ren "%IMG_FILE%" %BASENAME%.vhd
vhdtool /convert "%VHD_FILE%"

echo.
echo ====================================
echo Mounting VHD disk image...
echo ====================================
(echo select vdisk file="%VHD_FILE%" & echo attach vdisk & echo create partition primary & echo select partition 1 & echo format fs=fat32 quick & echo assign letter=%DRIVE_LETTER% & echo exit) | diskpart

echo.
echo ====================================
echo Creating WinPE dir...
echo ====================================
call copype amd64 "%WINPE_DIR%" >nul
cd /d "%CWD%"
::echo on

echo.
echo ====================================
echo Updating WinPE dir...
echo ====================================
@for /f %%a in ('dir /b "%WINPE_DIR%\media\*-*"') do @rmdir /q /s "%WINPE_DIR%\media\%%a"

echo.
echo ====================================
echo Updating boot.wim...
echo ====================================

dism /Mount-Wim /MountDir:"%WINPE_DIR%\mount" /wimfile:"%WINPE_DIR%\media\sources\boot.wim" /index:1

REM Add PowerShell
Dism /Image:"%WINPE_DIR%\mount" /Add-Package /PackagePath:"%WinPERoot%\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Image:"%WINPE_DIR%\mount" /Add-Package /PackagePath:"%WinPERoot%\amd64\WinPE_OCs\WinPE-NetFx.cab"
Dism /Image:"%WINPE_DIR%\mount" /Add-Package /PackagePath:"%WinPERoot%\amd64\WinPE_OCs\WinPE-PowerShell.cab"

REM Copy fonts to Windows\fonts\
xcopy /q /y data\fonts\* "%WINPE_DIR%\mount\Windows\Fonts\"

REM Copy contents of bin to Windows\System32
xcopy /q /y /e data\bin\* "%WINPE_DIR%\mount\Windows\System32\"

dism /Unmount-Wim /MountDir:"%WINPE_DIR%\mount" /commit

REM Clean up
dism /Export-Image /SourceImageFile:"%WINPE_DIR%\media\sources\boot.wim" /SourceIndex:1 /DestinationImageFile:"%WINPE_DIR%\media\sources\boot_cleaned.wim"
del /f "%WINPE_DIR%\media\sources\boot.wim"
ren "%WINPE_DIR%\media\sources\boot_cleaned.wim" boot.wim

echo.
echo ====================================
echo Write WinPE to mounted VHD disk image...
echo ====================================
call MakeWinPEMedia /UFD /F "%WINPE_DIR%" %DRIVE_LETTER%:
cd /d "%CWD%"

echo.
echo ====================================
echo Setting volume label...
echo ====================================
label %DRIVE_LETTER%: TinyWin11

echo.
echo ====================================
echo Copying resources...
echo ====================================
xcopy /q /y /e dist\shell %DRIVE_LETTER%:\shell\
xcopy /q /y /e data\programs %DRIVE_LETTER%:\programs\
xcopy /q /y /e data\userprofile %DRIVE_LETTER%:\userprofile\
copy /y data\autorun.inf %DRIVE_LETTER%:\
copy /y data\TinyWin11.ico %DRIVE_LETTER%:\

echo.
echo ====================================
echo Zeroing free disk space...
echo ====================================
sdelete64.exe -z %DRIVE_LETTER%:

echo.
echo ====================================
echo Unmounting VHD disk image...
echo ====================================
(echo select vdisk file="%VHD_FILE%" & echo detach vdisk & echo exit) | diskpart

echo.
echo ====================================
echo Removing VHD footer...
echo ====================================
fsutil file seteof %VHD_FILE% %IMG_SIZE%
ren %VHD_FILE% %BASENAME%.img

echo.
echo ====================================
echo Creating VMDK disk image...
echo ====================================
qemu-img.exe convert -f raw "%IMG_FILE%" -O vmdk "%VMDK_FILE%"

echo.
echo Done.
