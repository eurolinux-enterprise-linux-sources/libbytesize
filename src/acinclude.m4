dnl autoconf macros for libbytesize
dnl
dnl Copyright (C) 2014  Red Hat, Inc.
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU Lesser General Public License as published
dnl by the Free Software Foundation; either version 2.1 of the License, or
dnl (at your option) any later version.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU Lesser General Public License for more details.
dnl
dnl You should have received a copy of the GNU Lesser General Public License
dnl along with this program.  If not, see <http://www.gnu.org/licenses/>.
dnl
dnl THIS IS A MODIFIED VERSION OF THE ANACONDA'S acinclude.m4 FILE.
dnl
dnl Author: David Shea <dshea@redhat.com>
dnl         Vratislav Podzimek <vpodzime@redhat.com>

dnl LIBBYTESIZE_SOFT_FAILURE(MESSAGE)
dnl
dnl Store a message that in some contexts could be considered indicative
dnl of a failure, but in other contexts could be indicative of who cares.
dnl
dnl Any message sent to this macro will be stored, and they can all be
dnl displayed at the end of configure using the LIBBYTESIZE_FAILURES macro.
AC_DEFUN([LIBBYTESIZE_SOFT_FAILURE], [dnl
AS_IF([test x"$libbytesize_failure_messages" = x],
    [libbytesize_failure_messages="[$1]"],
    [libbytesize_failure_messages="$libbytesize_failure_messages
[$1]"
])])dnl

dnl LIBBYTESIZE_PKG_CHECK_MODULES(VARIABLE-PREFIX, MODULES)
dnl
dnl Check whether a module is available, using pkg-config. Instead of failing
dnl if a module is not found, store the failure in a message that can be
dnl printed using the LIBBYTESIZE_FAILURES macro.
dnl
dnl The syntax and behavior of VARIABLE-PREFIX and MODULES is the same as for
dnl PKG_CHECK_MODULES.
AC_DEFUN([LIBBYTESIZE_PKG_CHECK_MODULES], [dnl
PKG_CHECK_MODULES([$1], [$2], [], [LIBBYTESIZE_SOFT_FAILURE($[$1]_PKG_ERRORS)])
])dnl

dnl LIBBYTESIZE_PKG_CHECK_EXISTS(MODULES)
dnl
dnl Check whether a module exists, using pkg-config. Instead of failing
dnl if a module is not found, store the failure in a message that can be
dnl printed using the LIBBYTESIZE_FAILURES macro.
dnl
dnl The syntax and behavior of MODULES is the same as for
dnl PKG_CHECK_EXISTS.
AC_DEFUN([LIBBYTESIZE_PKG_CHECK_EXISTS], [dnl
PKG_CHECK_EXISTS([$1], [], [LIBBYTESIZE_SOFT_FAILURE([Check for $1 failed])])
])dnl

dnl LIBBYTESIZE_FAILURES
dnl
dnl Print the failure messages collected by LIBBYTESIZE_SOFT_FAILURE and
dnl LIBBYTESIZE_PKG_CHECK_MODULES
AC_DEFUN([LIBBYTESIZE_FAILURES], [dnl
AS_IF([test x"$libbytesize_failure_messages" = x], [], [dnl
echo ""
echo "*** Libbytesize encountered the following issues during configuration:"
echo "$libbytesize_failure_messages"
echo ""
echo "*** Libbytesize will not successfully build without these missing dependencies"
])])dnl
