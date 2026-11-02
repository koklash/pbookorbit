#!/bin/bash
set -e

SYSROOT="/Users/nmi/.pocketbook_build/sdk/arm-buildroot-linux-gnueabihf_sdk-buildroot/arm-buildroot-linux-gnueabihf/sysroot"
BUILD_DIR="/Users/nmi/.pocketbook_build/project/pbookorbit/build_native"

cd "$BUILD_DIR"

echo "=== Linking pbookorbit.app for ARM Hard-Float (RK3566) ==="
armv7-unknown-linux-gnueabihf-g++ \
  --sysroot="$SYSROOT" \
  -mfloat-abi=hard -mfpu=neon \
  -Wl,-rpath-link,"$SYSROOT/usr/local/qt6/lib:$SYSROOT/usr/lib:$SYSROOT/usr/local/lib" \
  -Wl,-O1 \
  -o pbookorbit.app \
  main.o bookfinder.o browser.o booklistmodel.o bookorbitclient.o database.o diagnostics.o downloads.o accents.o covers.o eink.o einkcolors.o invertedimageprovider.o launchertile.o themeimageprovider.o qrc_qml.o moc_bookfinder.o moc_browser.o moc_booklistmodel.o moc_bookorbitclient.o moc_diagnostics.o moc_downloads.o moc_covers.o moc_eink.o moc_launchertile.o \
  -L"$SYSROOT/usr/local/qt6/lib" -L"$SYSROOT/usr/local/lib" -L"$SYSROOT/usr/lib" \
  -lQt6Quick -lQt6OpenGL -lQt6Gui -lQt6QmlModels -lQt6Qml -lQt6Network -lQt6Core \
  -lcommon_utilities -linkview -lsqlite3 -lpthread

echo "=== Strip binary ==="
armv7-unknown-linux-gnueabihf-strip pbookorbit.app

echo "=== Verifying ELF Binary ==="
file pbookorbit.app
readelf -lW pbookorbit.app | grep "program interpreter"
readelf -lW pbookorbit.app | grep "GNU_STACK"
