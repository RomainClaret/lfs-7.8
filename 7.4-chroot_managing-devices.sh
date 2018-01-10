#!/bin/bash

CHAPTER_SECTION=4
INSTALL_NAME=managing-dev

echo ""
echo "### ---------------------------"
echo "###     MANAGING DEVICES    ###"
echo "###        CHAPTER 7.$CHAPTER_SECTION      ###"
echo "### Managing Devices"
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
echo "... Creating Custom Udev Rules"
bash /lib/udev/init-net-rules.sh

echo ""
echo "... Review content of /etc/udev/rules.d/70-persistent-net.rules"
cat /etc/udev/rules.d/70-persistent-net.rules | tee $LOG_FILE-persistent-net-rules.log
echo "<-- End"

echo ""
echo "######### END OF CHAPTER 7.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./7.5-chroot_network.sh"
echo ""
