#!/usr/bin/env bash

SOURCE_DIR="$(readlink -f $(dirname $0))"
BUILD_DIR="$SOURCE_DIR/build/lowlevel"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"


# Write response file with quoted strings
RESPONSE_FILE="$BUILD_DIR/responsefile"
cat << EOF > "$RESPONSE_FILE"
"$SOURCE_DIR/main.c"
EOF

cd "$builddir"

set -x
qcc -v @${RESPONSE_FILE} -o exe
