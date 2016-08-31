#!/bin/bash

CHAPTER_SECTION=4

echo ""
echo "### ---------------------------"
echo "###    CHROOT ENVIRONMENT   ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Entering the Chroot Environment"
echo "### Must be run as \"root\" user"
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
check_partitions
is_user root

echo ""
echo "... Entering the Chroot Environment"
rm -rf $LFS_MOUNT_TOOLS/lfs
cp -r $(pwd) $LFS_MOUNT_TOOLS/lfs

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "--> Note that the bash prompt will say \"I have no name!\" This is normal because the /etc/passwd file has not been created yet."
echo "### Please run the next steps if you are on Debian:"
echo "### cd /tools/lfs"
echo "### ./6.all-part-2-chroot_installing-basic-system.sh"
echo ""

chroot "$LFS_MOUNT" /tools/bin/env -i \
  HOME=/root \
  TERM="$TERM" \
  PS1='\u:\w\$ ' \
  PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
  /tools/bin/bash --login +h

echo ""
echo "---> You have exited the shell 3/3"
echo "### Please continue the instructions from 6.72"
echo ""
