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
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo "... Creating and mounting $LFS_PARTITION_ROOT at $LFS_MOUNT"
mkdir -pv "$LFS_MOUNT"
mount -t ext4 $LFS_PARTITION_ROOT $LFS_MOUNT

echo ""
echo "... Enabling swap partition"
/sbin/swapon -v $LFS_PARTITION_SWAP

echo ""
echo "... Validating the environment again"
check_partitions

echo ""
echo "######### END OF CHAPTER 2.5 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./3.all-root_packages-patches.sh"
echo ""

exit 0
