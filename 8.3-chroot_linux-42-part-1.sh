#!/bin/bash

CHAPTER_SECTION=3
INSTALL_NAME=linux

echo ""
echo "### ---------------------------"
echo "###      LINUX-42-PART-1    ###"
echo "###        CHAPTER 8.$CHAPTER_SECTION      ###"
echo "### Linux-4.20"
echo "### Must be run as \"chroot\" user"
echo "### ---------------------------"

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

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_8$CHAPTER_SECTION-$INSTALL_NAME
cd /sources
check_tarball_uniqueness
extract_tarball
cd $(ls -d /sources/$INSTALL_NAME*/)

time
{
  echo ""
  echo "... Cleaning up the kernel tree"
  make mrproper $PROCESSOR_CORES &> $LOG_FILE-make-mrproper.log
}
echo ""
echo "######### END OF CHAPTER 8.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "!! Careful: Be sure to select at least the option below:"
echo "Device Drivers  --->"
echo "  Generic Driver Options  --->"
echo "    [ ] Support for uevent helper [CONFIG_UEVENT_HELPER]"
echo "    [*] Maintain a devtmpfs filesystem to mount at /dev [CONFIG_DEVTMPFS"
echo "### Please run the next steps:"
echo "### pushd /sources/linux*"
echo "### make defconfig"
echo "### make menuconfig"
echo "### popd"
echo "### ./8.3-chroot_linux-42-part-2.sh"
echo ""




exit 0
