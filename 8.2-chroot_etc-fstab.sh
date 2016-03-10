#!/bin/bash

CHAPTER_SECTION=2
INSTALL_NAME=etc-fstab

echo ""
echo "### ---------------------------"
echo "###         ETC-FSTAB       ###"
echo "###        CHAPTER 7.$CHAPTER_SECTION      ###"
echo "### Create the /etc/fstab File"
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
LOG_FILE=$LFS_BUILD_LOGS_7$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Creating /etc/fstab"
cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file      mount   type      options           dump fsck
#                                                    ordr
/dev/sdb2   /       ext4      defaults            1 1
/dev/sdb1   swap    swap      pri=1               0 0
proc        /proc   proc      nosuid,noexec,nodev 0 0
sysfs       /sys    sysfs     nosuid,noexec,nodev 0 0
devpts      /dev/pts devpts   gid=5,mode=620      0 0
tmpfs       /run    tmpfs     defaults            0 0
devtmpfs    /dev    devtmpfs  mode=0755,nosuid    0 0
# End /etc/fstab
EOF

echo ""
echo "... Review content of /etc/fstab"
cat /etc/fstab | tee $LOG_FILE-fstab.log
echo "<-- End"

echo ""
echo "######### END OF CHAPTER 7.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./8.3-chroot_linux-42.sh"
echo ""

exit 0
