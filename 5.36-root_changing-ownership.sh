#!/bin/bash

CHAPTER_SECTION=36

echo ""
echo "### ---------------------------"
echo "###         OWNERSHIP       ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### Changing Ownership"
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
is_user lfs
check_tools

echo ""
echo "... Transfering back the ownership"
echo ".... $LFS_MOUNT_TOOLS"
chown -R root:root $LFS_MOUNT_TOOLS
echo ".... $LFS_BUILD_LOGS"
chown -R root:root $LFS_BUILD_LOGS

echo ""
echo "... Backing up tools directory"
cp -r $LFS_MOUNT_TOOLS $LFS_ROOT_BACKUP_FOLDER

echo ""
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "We are highly recommanding you to do a snapshot or a full backup of some sort"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

echo ""
echo "######### END OF CHAPTER 5 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.xx.sh"
echo ""

exit 0
