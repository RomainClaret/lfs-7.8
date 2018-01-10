#!/bin/bash

CHAPTER_SECTION=72
INSTALL_NAME=stripping

echo ""
echo "### ---------------------------"
echo "###          STRIPPING      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Stripping Again"
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
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next steps:"
echo "### exit"
echo "### exit"
echo "### exit"
echo "### chroot $LFS_MOUNT /tools/bin/env -i HOME=/root TERM=$TERM PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /tools/bin/bash --login"
echo "### cd /root/lfs"
echo "### /tools/bin/find /{,usr/}{bin,lib,sbin} -type f -exec /tools/bin/strip --strip-debug '{}' ';'"
echo "### ./6.73-chroot_cleaning-up.sh"
echo ""
