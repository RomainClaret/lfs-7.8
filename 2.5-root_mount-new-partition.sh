#!/bin/bash
echo ""
echo "### --------------------------"
echo "###   MOUNT NEW PARTITION  ###"
echo "###       CHAPTER 2.5      ###"
echo "### Mounting the New Partition"
echo "### Must be run as \"root\""
echo "### --------------------------"

echo ""
echo "... Loading commun functions and variables"
if [ ! -f ./script-root_commun-functions.sh ]
then
  echo "!! Fatal Error 1: './script-root_commun-functions.sh' not found."
  exit 1
fi
source ./script-root_commun-functions.sh

if [ ! -f ./script-root_commun-variables.sh ]
then
  echo "!! Fatal Error 1: './script-root_commun-variables.sh' not found."
  exit 1
fi
source ./script-root_commun-variables.sh

echo ""
echo "... Validating the environment"
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo "... Creating and mounting $LFS_PARTITION_ROOT at $LFS_MOUNT_DIR"
mkdir -pv "$LFS_MOUNT_DIR"
mount -t ext4 $LFS_PARTITION_ROOT $LFS_MOUNT_DIR

echo ""
echo "... Enabling swap partition"
/sbin/swapon -v $LFS_PARTITION_SWAP

echo ""
blkid "$LFS_PARTITION_ROOT" | grep ext4
if [ ! $? -eq 0 ]
then
  echo "!! Fatal Error 4: $LFS_PARTITION_ROOT not mounted, run this script again or do manually"
  exit 4
fi
echo "!! Info: $LFS_PARTITION_ROOT has been mounted correctly"

echo ""
swapon -s | grep "$LFS_PARTITION_SWAP"
if [ ! $? -eq 0 ]
then
  echo "!! Fatal Error 5: $LFS_PARTITION_SWAP has not the swap activated, run this script again or do manually"
fi
echo "!! Info: $LFS_PARTITION_SWAP is correctly configured as swap"

echo ""
echo "######### END OF CHAPTER 2.5 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./3.all-root_packages-patches.sh"
echo ""

exit 0
