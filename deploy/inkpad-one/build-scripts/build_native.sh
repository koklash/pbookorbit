#!/bin/bash
set -e

SYSROOT="/Users/nmi/.pocketbook_build/sdk/arm-buildroot-linux-gnueabihf_sdk-buildroot/arm-buildroot-linux-gnueabihf/sysroot"
QT_HOST="/Users/nmi/.pocketbook_build/qt682/6.8.2/macos"
PROJECT_DIR="/Users/nmi/.pocketbook_build/project/pbookorbit"
BUILD_DIR="$PROJECT_DIR/build_native"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
rm -rf *

export PB_KIT="/Users/nmi/.pocketbook_build"
export PATH="$QT_HOST/bin:$QT_HOST/libexec:$PATH"

"$QT_HOST/bin/qmake" "$PROJECT_DIR/pbookorbit.pro" \
  -spec arm-linux-gnueabihf-g++ \
  "QMAKE_CFLAGS+=--sysroot=$SYSROOT -mfloat-abi=hard -mfpu=neon" \
  "QMAKE_CXXFLAGS+=--sysroot=$SYSROOT -mfloat-abi=hard -mfpu=neon" \
  "QMAKE_LFLAGS+=--sysroot=$SYSROOT -mfloat-abi=hard -Wl,-rpath-link,$SYSROOT/usr/local/qt6/lib:$SYSROOT/usr/lib:$SYSROOT/usr/local/lib" \
  "INCLUDEPATH+=$SYSROOT/usr/local/qt6/include $SYSROOT/usr/local/include $SYSROOT/usr/include" \
  "LIBS+=-L$SYSROOT/usr/local/qt6/lib -L$SYSROOT/usr/local/lib -L$SYSROOT/usr/lib"

echo "=== Generated Makefile with Qt 6.8.2 moc/rcc/qmake ==="
make -j8

echo "=== Success! Checking output: ==="
file pbookorbit.app || file pbookorbit
