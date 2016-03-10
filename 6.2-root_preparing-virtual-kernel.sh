#!/bin/bash

CHAPTER_SECTION=2
INSTALL_NAME=preparing-virtual-kernel

echo ""
echo "### -----------------------------"
echo "###  PREPARING VIRTUAL KERNEL ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Preparing Virtual Kernel File Systems"
echo "### Must be run as \"root\" user"
echo "### -----------------------------"

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
echo "... Setting up the environment"
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Preparing Virtual Kernel File Systems" | tee $LOG_FILE
mkdir -pv $LFS_MOUNT/{dev,proc,sys,run} &>> $LOG_FILE

echo "... Creating Initial Device Nodes" | tee -a $LOG_FILE
mknod -m 600 $LFS_MOUNT/dev/console c 5 1 &>> $LOG_FILE
mknod -m 666 $LFS_MOUNT/dev/null c 1 3 &>> $LOG_FILE

echo "... Mounting and Populating /dev" | tee -a $LOG_FILE
mount -v --bind /dev $LFS_MOUNT/dev &>> $LOG_FILE

echo "... Mounting Virtual Kernel File Systems" | tee -a $LOG_FILE
mount -vt devpts devpts $LFS_MOUNT/dev/pts -o gid=5,mode=620 &>> $LOG_FILE
mount -vt proc proc $LFS_MOUNT/proc &>> $LOG_FILE
mount -vt sysfs sysfs $LFS_MOUNT/sys &>> $LOG_FILE
mount -vt tmpfs tmpfs $LFS_MOUNT/run &>> $LOG_FILE

echo "... Checking symlink: /dev/shm to /run/shm" | tee -a $LOG_FILE
if [ -h $LFS_MOUNT/dev/shm ]; then
  echo '---> creating shm directory' | tee -a $LOG_FILE
  mkdir -pv $LFS_MOUNT/$(readlink $LFS_MOUNT/dev/shm) &>> $LOG_FILE
fi

get_build_errors_mnt_lfs

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.4-root_chroot-environment.sh"
echo ""

exit 0
