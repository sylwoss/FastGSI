@echo off
color 0A
title FastGSI - sylwoss
echo =-=-=-=-=-=-=-=
echo  =  FastGSI  =
echo =-=-=-=-=-=-=-=
echo by sylwoss
echo github.com/sylwoss
echo =-=-=-=-=-=-=-=-=-=

echo Your phone must be in adb!

:: Check device in ADB mode
:check_adb
echo Checking the phone connection (ADB)...

for /f "skip=1 tokens=1,2" %%a in ('adb devices') do (
    if "%%b"=="device" (
        set device_found=1
    )
)

:: If device is not found in ADB, check in fastboot
if not defined device_found (
    echo Phone not detected in ADB. Checking Fastboot mode...
    fastboot devices | findstr /r /c:"device$" > nul
    if %errorlevel%==0 (
        echo Device detected in Fastboot. Rebooting to Fastboot mode...
        fastboot reboot fastboot
        timeout /t 5
    ) else (
        echo Phone not detected in Fastboot. Please check the connection.
        timeout /t 3
        goto check_adb
    )
)

echo Phone detected! Continuing with flashing process...
timeout /t 2

:: Reboot to fastboot if detected in ADB
adb reboot fastboot
timeout /t 5

:wait_for_fastboot
echo Waiting for fastboot mode...

set device_found=

:: Check if the device is in fastboot mode
for /f "tokens=1,2" %%a in ('fastboot devices') do (
    if "%%b"=="fastboot" (
        set device_found=1
    )
)

:: If device is not detected in fastboot, check again
if not defined device_found (
    echo Phone not detected in Fastboot. Checking again...
    timeout /t 3
    goto wait_for_fastboot
)

:: Set GSI file path
set gsi_file=system.img

:: Check if the GSI file exists
if not exist "%gsi_file%" (
    echo Error: The file system.img does not exist in this folder!
    pause
    if you found any errors let me know!
    exit /b
)

:: Delete product partitions
echo Deleting product partitions...
fastboot delete-logical-partition product
fastboot delete-logical-partition product_a
fastboot delete-logical-partition product_b

:: Flash the GSI file
echo Flashing GSI...
fastboot flash system "%gsi_file%"

:: Clean user data
echo Data cleaning...
fastboot erase userdata

:: Reboot the device
echo Restarting the device...
fastboot reboot

echo Installation completed!
pause
if you found any errors let me know!
exit
