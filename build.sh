#!/bin/bash

SOURCE_PATH="$PWD"
IPERF3_PATH="$SOURCE_PATH/iperf"
PREFIX_PATH="$IPERF3_PATH/output_bin"
BINDIR_PATH="$PREFIX_PATH/bin"
OUTDIR_PATH="$SOURCE_PATH/bin"
CYGDRV_PATH="/cygdrive"

echo "       Source Path: $SOURCE_PATH"
echo "iperf3 Source Path: $IPERF3_PATH"
echo "       Prefix Path: $PREFIX_PATH"
echo "       BinDir Path: $BINDIR_PATH"
echo "       OutDir Path: $OUTDIR_PATH"

cd $IPERF3_PATH

autoreconf -fi
rm -rf config.cache

./configure --prefix="$PREFIX_PATH"
sed -i.bak -e "s/\(allow_undefined=\)yes/\1no/" libtool
make -j4
make install

cp -r "$BINDIR_PATH" "$SOURCE_PATH"

cd "$OUTDIR_PATH"

readarray -t TMP_PATH < <(cygcheck ./iperf3.exe)
readarray -t TMP_PATH < <(for i in "${TMP_PATH[@]}"; do echo $(cygpath -u $i) | grep -v "$CYGDRV_PATH"; done)

for i in "${TMP_PATH[@]}"; do 
    if [[ ! -f "./$(basename $i)" ]]; then
        cp "$i" .
    fi
done

cd $SOURCE_PATH

echo "Done, Binaries are available in $(cygpath.exe -w $OUTDIR_PATH)"
