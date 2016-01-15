#!/bin/bash
echo ""
echo "### ------------------------------"
echo "#### START OF INITIALIZATION ####"
echo "### Checking the host system"
echo "### Must be run as \"root\""
echo "### ------------------------------"
echo ""
echo "... Loading commun functions"

if [ ! -f ./script-root_commun-functions.sh ]; then
    echo "!! Fatal Error 1: './script-root_commun-functions.sh' not found.";
    exit 1;
fi
source ./script-root_commun-functions.sh

echo ""
echo "... Validating the environment"
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]; then
    echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash";
    exit 3;
fi

echo ""
echo "... Self check"
self_check

echo ""
echo "... Validating required software versions"
sh script-root_version-check.sh
echo ""
echo "... Validating required libraries"
sh script-root_library-check.sh
echo ""

echo ""
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please follow the instructions bellow:"
echo "### Verify that the versions match"
echo "### Also cross check with the book 7.8"
echo ""
echo "- Bash-3.2"
echo "- >= Binutils-2.17 -> Binutils-2.25.1 (Versions greater than 2.25.1 are not recommended as they have not been tested)"
echo "- >= Bison-2.3 (/usr/bin/yacc should be a link to bison or small script that executes bison)"
echo "- >= Bzip2-1.0.4"
echo "- >= Coreutils-6.9"
echo "- >= Diffutils-2.8.1"
echo "- >= Findutils-4.2.31"
echo "- >= Gawk-4.0.1 (/usr/bin/awk should be a link to gawk)"
echo "- >= GCC-4.1.2 -> GCC-5.2.0 including the C++ compiler, g++ (Versions greater than 5.2.0 are not recommended as they have not been tested)"
echo "- >= Glibc-2.11 -> Glibc-2.22 (Versions greater than 2.22 are not recommended as they have not been tested)"
echo "- >= Grep-2.5.1a"
echo "- >= Gzip-1.3.12"
echo "- >= Linux Kernel-2.6.32"
echo "- >= M4-1.4.10"
echo "- >= Make-3.81"
echo "- >= Patch-2.5.4"
echo "- >= Perl-5.8.8"
echo "- >= Sed-4.1.5"
echo "- >= Tar-1.22"
echo "- >= Texinfo-4.7"
echo "- >= Xz-5.0.0"
echo ""
echo "######### END OF INITIALIZATION #########"

exit 0
