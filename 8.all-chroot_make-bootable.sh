#!/bin/bash

echo ""
echo "### -------------------------------"
echo "###         MAKE BOOTABLE       ###"
echo "###         CHAPTER 8.all       ###"
echo "### Making the LFS System Bootable"
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
is_user root
check_chroot

./8.2-chroot_etc-fstab.sh
./8.3-chroot_linux-42.sh
./8.4-chroot_grub.sh
