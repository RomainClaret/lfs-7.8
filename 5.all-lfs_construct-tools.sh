#!/bin/bash
echo ""
echo "### -------------------------------"
echo "###     CONSTRUCT TEMP SYSTEM   ###"
echo "###         CHAPTER 5.all       ###"
echo "### Constructing a Temporary System"
echo "### Must be run as \"lfs\" user"
echo "### -------------------------------"

echo ""
echo "... Loading commun functions and variables"
if [ ! -f ./script-all_commun-functions.sh ]
then
  echo "!! Fatal Error 1: './script-all_commun-functions.sh' not found."
  exit 1
fi
source ./script-all_commun-functions.sh

if [ ! -f ./script-all_commun-variables.sh ]
then
  echo "!! Fatal Error 1: './script-all_commun-variables.sh' not found."
  exit 1
fi
source ./script-all_commun-variables.sh

echo ""
echo "... Validating the environment"
check_partitions
is_user lfs

# ./5.3-lfs_check-tools.sh
# ./5.4-lfs_binutils-2.25.1-pass-1.sh
# ./5.5-lfs_gcc-5.2.0-pass-1.sh
# ./5.6-lfs_linux-4.2-api-headers.sh
# ./5.7-lfs_glibc-2.22.sh
# ./5.8-lfs_libstdcpp-5.2.0.sh
# ./5.9-lfs_binutils-2.25.1-pass-2.sh
# ./5.10-lfs_gcc-5.2.0-pass-2.sh
./5.11-lfs_tcl-core-8.6.4.sh
./5.12-lfs_expect-5.45.sh
./5.13-lfs_dejagnu-1.5.3.sh
# ./5.14-lfs_check-0.10.0.sh
# ./5.15-lfs_ncurses-6.0.sh
# ./5.16-lfs_bash-4.3.30.sh
# ./5.17-lfs_bzip2-1.0.6.sh
# ./5.18-lfs_coreutils-8.24.sh
# ./5.19-lfs_diffutils-3.3.sh
# ./5.20-lfs_file-5.24.sh
# ./5.21-lfs_findutils-4.4.2.sh
# ./5.22-lfs_gawk-4.1.3.sh
# ./5.23-lfs_gettext-0.19.5.1.sh
# ./5.24-lfs_grep-2.21.sh
# ./5.25-lfs_gzip-1.6.sh
# ./5.26-lfs_m4-1.4.17.sh
# ./5.27-lfs_make-4.1.sh
# ./5.28-lfs_patch-2.7.5.sh
# ./5.29-lfs_perl-5.22.0.sh
# ./5.30-lfs_sed-4.2.2.sh
# ./5.31-lfs_tar-1.28.sh
# ./5.32-lfs_texinfo-6.0.sh
# ./5.33-lfs_util-linux-2.27.sh
# ./5.34-lfs_xz-5.2.1.sh
# ./5.35-lfs_stripping.sh
# ./5.36-lfs_changing-ownership.sh
