#!/bin/bash

echo ""
echo "### -------------------------------"
echo "###    INSTALLING BASIC SYSTEM  ###"
echo "###         CHAPTER 6.all       ###"
echo "### Installing Basic System Software"
echo "### Must be run as \"chroot\" user"
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
check_chroot

echo ""
echo "READ CAREFULLY"
echo "Running this script will be long, ~6h"
echo "The compilation time is ~5h in the best cases."
echo "But note that you will be required during some of the steps."
echo "When steps are required from you, the terminal will produce a sound. But check often, in case you didn't hear it."
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

./6.7-chroot_api-headers.sh
./6.8-chroot_man-pages.sh
./6.9-chroot_glibc.sh
./6.10-chroot_toolchain.sh
./6.11-chroot_zlib.sh
./6.12-chroot_file.sh
./6.13-chroot_binutils.sh
./6.14-chroot_gmp.sh
./6.15-chroot_mpfr.sh
./6.16-chroot_mpc.sh
./6.17-chroot_gcc.sh
./6.18-chroot_bzip2.sh
./6.19-chroot_pkg-config.sh
./6.20-chroot_ncurses.sh
./6.21-chroot_attr.sh
./6.22-chroot_acl.sh
./6.23-chroot_libcap.sh
./6.24-chroot_sed.sh
./6.25-chroot_shadow.sh
./6.26-chroot_psmisc.sh
./6.27-chroot_procps-ng.sh
./6.28-chroot_e2fsprogs.sh
./6.29-chroot_coreutils.sh
./6.30-chroot_iana-etc.sh
./6.31-chroot_m4.sh
./6.32-chroot_flex.sh
./6.33-chroot_bison.sh
./6.34-chroot_grep.sh
./6.35-chroot_readline.sh
./6.36-chroot_bash.sh
