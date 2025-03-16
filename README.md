# FastGSI

**FastGSI** is a script that automates flashing a Generic System Image (GSI) to your Android device.
FastGSI.bat **MUST** be in fastboot folder!

# Features
- Automatically detects ADB and Fastboot
- Flashes `system.img`
- Cleans up partitions and wipes data

# Requirements
· **Windows OS**
· **ADB** and **Fastboot** installed
· **system.img** file
· Device must be in **system** for flashing

# Usage
1. Run `FastGSI.bat`.
2. Connect device in **system mode** (not Fastboot).
3. The script will flash the GSI and reboot your device.

# Troubleshooting
- Ensure **USB debugging** is enabled and **system.img** is present.
