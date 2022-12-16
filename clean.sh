#!/bin/bash

SOURCE_PATH="$PWD"
IPERF3_PATH="$SOURCE_PATH/iperf"
PREFIX_PATH="$IPERF3_PATH/output_bin"
OUTDIR_PATH="$SOURCE_PATH/bin"

echo "       Source Path: $SOURCE_PATH"
echo "iperf3 Source Path: $IPERF3_PATH"
echo "       Prefix Path: $PREFIX_PATH"
echo "       OutDir Path: $OUTDIR_PATH"

rm -rf "$OUTDIR_PATH"
rm -rf "$PREFIX_PATH"

cd "$IPERF3_PATH"

make distclean

cd "$SOURCE_PATH"
