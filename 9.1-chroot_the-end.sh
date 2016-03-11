#!/bin/bash

CHAPTER_SECTION=1
INSTALL_NAME=the-end

echo ""
echo "### ---------------------------"
echo "###          THE-END        ###"
echo "###        CHAPTER 9.$CHAPTER_SECTION      ###"
echo "### The End"
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
LOG_FILE=$LFS_BUILD_LOGS_9$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Ending starts now"
echo $LFS_DISTRIB_RELEASE > /etc/lfs-release
cat > /etc/lsb-release << EOF
DISTRIB_ID=$LFS_DISTRIBUTION_ID
DISTRIB_RELEASE=$LFS_DISTRIBUTION_RELEASE
DISTRIB_CODENAME=$LFS_DISTRIBUTION_CODENAME
DISTRIB_DESCRIPTION=$LFS_DISTRIBUTION_DESCRIPTION
EOF
cat /etc/lfs-release > $LOG_FILE-lfs-release
cat /etc/lsb-release > $LOG_FILE-lsb-release

echo ""
echo "######### END OF CHAPTER 9.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "Here we are, soon we will boot on our LFS."
echo "### Please run the next steps:"
echo "### logout"
echo "### update-grub"
echo "### ./9.3-chroot-reboot.sh"
echo ""

exit 0
