#!/bin/bash

export LDFLAGS=$(echo "${LDFLAGS}" | sed "s/-Wl,-dead_strip_dylibs//g")
export LDFLAGS=$(echo "${LDFLAGS}" | sed "s/-Wl,--as-needed//g")

autoreconf -i
chmod +x configure

./configure --prefix=${PREFIX} --enable-shared --host=$HOST || (cat config.log; false)

make -j${CPU_COUNT}
make check
make install
