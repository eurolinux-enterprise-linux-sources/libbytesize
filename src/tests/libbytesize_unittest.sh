#!/bin/bash

# If not run from automake, fake it
if [ -z "$srcdir" ]; then
    srcdir="$(dirname "$0")"
fi

python2 ${srcdir}/libbytesize_unittest.py
if [ 1 = 1 ]; then
    python3 ${srcdir}/libbytesize_unittest.py
fi

python2 ${srcdir}/libbytesize_unittest.py fr_FR.UTF8

if [ 1 = 1 ]; then
    python3 ${srcdir}/libbytesize_unittest.py fr_FR.UTF8
fi
