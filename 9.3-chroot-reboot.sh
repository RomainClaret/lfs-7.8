#!/bin/bash

CHAPTER_SECTION=3

echo ""
echo "### ---------------------------"
echo "###           REBOOT        ###"
echo "###        CHAPTER 9.$CHAPTER_SECTION      ###"
echo "### Unmount and Reboot"
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
echo "... Unmounting the virtual file systems"
umount -v $LFS_MOUNT/dev/pts
umount -v $LFS_MOUNT/dev
umount -v $LFS_MOUNT/run
umount -v $LFS_MOUNT/proc
umount -v $LFS_MOUNT/sys

echo "... Unmounting the LFS file system itself"
umount -v $LFS_MOUNT

echo ""
echo "So... this is the last attention we are needing from you."
echo "We finally did it."
echo "Congratulations for your brand new and fresh LFS."
echo "Live long and prosper."
echo "Be the BB-8 roll in your soul..."
echo ""
echo "Anyway... If everything went alright you should be able to reboot on LFS :)"
echo "See you on the other side... *Crossing the fingers*"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

echo "... Rebooting"
shutdown -r now
