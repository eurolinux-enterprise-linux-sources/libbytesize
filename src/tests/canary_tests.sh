#!/bin/sh -e
# Run the translation canary tests on the translatable strings

if [ 1 != 1 ]; then
    echo "Cannot run translations tests without python3, skipping."
    exit 0
fi

DISTRO=`busctl get-property org.freedesktop.hostname1 /org/freedesktop/hostname1 org.freedesktop.hostname1 OperatingSystemCPEName | cut -d ":" -f 3`
if [ $DISTRO == "centos" -o $DISTRO == "enterprise_linux" ]; then
    echo "Cannot run translations tests on CentOS/RHEL 7, skipping."
    exit 0
fi

# If not run from automake, fake it
if [ -z "$top_srcdir" ]; then
    top_srcdir="$(dirname "$0")/.."
fi

if [ -z "$top_builddir" ] ; then
    top_builddir="$(dirname "$0")/.."
fi

# Make sure libbytesize.pot is up to date
make -C ${top_builddir}/po libbytesize.pot-update >/dev/null 2>&1

PYTHONPATH="${PYTHONPATH}:${top_srcdir}/translation-canary"
export PYTHONPATH

# Run the translatable tests on the POT file
python3 -m translation_canary.translatable "${top_builddir}/po/libbytesize.pot"
