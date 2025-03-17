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

:check_adb
echo Checking the phone connection (ADB)...

for /f "skip=1 tokens=1,2" %%a in ('adb devices') do (
    if "%%b"=="device" (
        set device_found=1
    )
)

if not defined device_found (
    echo Phone not detected. Connect and enable ADB debugging.
    timeout /t 3
    goto check_adb
)

echo Phone detected in ADB! Switching to fastboot mode...
adb reboot fastboot
timeout /t 5

:wait_for_fastboot
echo Waiting for fastboot mode...

set device_found=

for /f "tokens=1,2" %%a in ('fastboot devices') do (
    if "%%b"=="fastboot" (
        set device_found=1
    )
)

if not defined device_found (
    echo Phone not detected in fastboot. Checking again...
    timeout /t 3
    goto wait_for_fastboot
)

set gsi_file=system.img

if not exist "%gsi_file%" (
    echo Error: The file system.img does not exist in this folder! Please rename your GSI and try again!
    echo If you found any errors, let me know!
    pause
    exit /b
)

echo Deleting product partitions...
fastboot delete-logical-partition product
fastboot delete-logical-partition product_a
fastboot delete-logical-partition product_b

echo Flashing GSI...
fastboot flash system "%gsi_file%"

:choose_wipe
echo Do you want to wipe data after flashing?
echo 1 - Yes (fastboot -w)
echo 2 - No
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo Wiping data...
    fastboot -w
) else if "%choice%"=="2" (
    echo Skipping data wipe...
) else (
    echo Invalid choice. Please enter 1 or 2.
    goto choose_wipe
)

echo Restarting the device...
fastboot reboot

echo Installation completed!
echo Thank You for using!
pause
exit
