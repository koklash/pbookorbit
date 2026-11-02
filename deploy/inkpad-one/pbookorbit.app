#!/bin/sh

# PBookOrbit launcher for PocketBook PB1030 (InkPad One / RK3566, FW 6.11+)
export GLIBC_TUNABLES="${GLIBC_TUNABLES}${GLIBC_TUNABLES:+:}glibc.rtld.execstack=2"
export LC_ALL="en_US.UTF-8"

# Resolve script directory
DIR="$(cd -P "$(dirname "$0")" && pwd)"

# Redirect log output to pbookorbit_start.log on root storage
exec >> "$DIR/../pbookorbit_start.log" 2>&1

echo "--- Starting PBookOrbit on $(date) ---"
echo "DIR=$DIR"

# PocketBook e-ink platform and software rendering (QRhi / SceneGraph)
export QT_QPA_PLATFORM_PLUGIN_PATH="/ebrmain/plugins/platforms:$DIR/platforms"
export QT_PLUGIN_PATH="/ebrmain/plugins:$DIR"
export QT_QPA_PLATFORM="pocketbook2"
export QSG_RHI_BACKEND="software"
export QT_QUICK_BACKEND="software"
export LD_LIBRARY_PATH="/ebrmain/lib:$DIR:$LD_LIBRARY_PATH"

if [ -f "$DIR/pbookorbit.bin" ]; then
    chmod +x "$DIR/pbookorbit.bin" 2>/dev/null
    exec "$DIR/pbookorbit.bin" "$@"
else
    echo "pbookorbit.bin not found!"
    exit 1
fi
