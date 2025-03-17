# FastGSI

**FastGSI** is a script that automates flashing a Generic System Image (GSI) to your Android device.

# **For the script to work properly, the phone must be in system mode (not fastboot) and have USB debugging enabled in the developer options!**

# Features
- Automatically detects ADB and Fastboot
- Flashes `system.img`
- Cleans partitions and deletes userdata and product, product_a, product_b

# Requirements
- **Windows OS**
- **ADB** and **Fastboot** installed
- **system.img** file
- Device must be in **system** for flashing
- **`FastGSI.bat` and `system.img` in Fastboot folder!**

# Usage
1. Run `FastGSI.bat`.
2. Connect device in **system mode** (not Fastboot).
3. The script will flash the GSI and reboot your device.

# Troubleshooting
- Ensure **USB debugging** is enabled and **system.img** is present.
