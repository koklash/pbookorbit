# PocketBook InkPad One (PB1030) Deployment Guide

This directory contains the launcher and installation instructions for running **BookOrbit** on the **PocketBook InkPad One (PB1030)** and other Rockchip RK3566 PocketBook devices running Firmware 6.11+.

## Architecture & Hardware Notes
* **Device:** PocketBook InkPad One (PB1030)
* **SoC:** Rockchip RK3566 (ARM64 kernel `5.10.226pocketbook`, 32-bit ARMv7 Hard-Float userland `armhf`)
* **Dynamic Linker:** `/lib/ld-linux-armhf.so.3`
* **Qt Version:** Device ships with Qt 6.10.3 in `/ebrmain/`
* **Platform Plugin:** `pocketbook2` (`/ebrmain/plugins/platforms/libqpocketbook2.so`)
* **Display:** 1404x1872 monochrome E Ink Mobius; requires Qt Software RHI rendering backend (`QSG_RHI_BACKEND=software`)

---

## Installation

1. Connect your PocketBook to your computer via USB and select **PC link**.
2. Download the pre-built release package `pbookorbit-inkpad-one-pb1030.tar.gz` from the Releases page.
3. Extract `pbookorbit.app` and rename it to `pbookorbit.bin`:
   * Copy `pbookorbit.bin` into `applications/` on your PocketBook.
4. Copy the launcher wrapper script `pbookorbit.app` into `applications/`:
   ```text
   /mnt/ext1/applications/pbookorbit.app  (executable shell wrapper)
   /mnt/ext1/applications/pbookorbit.bin  (compiled ARMhf binary)
   /mnt/ext1/applications/pbookorbit.bmp  (app icon, 110x110 8-bit bmp)
   /mnt/ext1/applications/pbookorbit_f.bmp
   ```
5. Safely eject the PocketBook and disconnect USB.

---

## Building from Source

To cross-compile on macOS or Linux for RK3566 `armhf`:
1. Use an `armv7-unknown-linux-gnueabihf` toolchain.
2. Link against the PocketBook SDK 6.11 sysroot:
   * Libraries: `-lQt6Quick -lQt6OpenGL -lQt6Gui -lQt6QmlModels -lQt6Qml -lQt6Network -lQt6Core -lcommon_utilities -linkview -lsqlite3 -lpthread`
3. Strip the binary and ensure stack flags are non-executable:
   ```sh
   armv7-unknown-linux-gnueabihf-strip pbookorbit.app
   ```
