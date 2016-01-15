#!/bin/bash
echo ""
echo "### ----------------------------------------"
echo "#### START OF NEW PARTITION PREPARATION ####"
echo "####             CHAPTER 2.3            ####"
echo "### Creating a File System on the Partition"
echo "### Must be run as \"root\""
echo "### ----------------------------------------"
echo ""
echo "... Loading commun functions and variables"

if [ ! -f ./script-root_commun-functions.sh ]; then
    echo "!! Fatal Error 1: './script-root_commun-functions.sh' not found.";
    exit 1;
fi
source ./script-root_commun-functions.sh

if [ ! -f ./script-root_commun-variables.sh ]; then
    echo "!! Fatal Error 1: './script-root_commun-variables.sh' not found.";
    exit 1;
fi
source ./script-root_commun-variables.sh

echo ""
echo "... Validating the environment"
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]; then
    echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash";
    exit 3;
fi

echo ""
echo "... Verifying lfs health"
if id -u $LFS_USERNAME >/dev/null 2>&1; then
  echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
  echo "### We have dectected that the lfs default user account exists."
  echo "### This user is used to build LFS."
  echo "### Do you wish to start from scratch a new LFS build?"
  echo "### We would delete the user, its group, backuped tools and logs"
  echo ""
  read -p "Would you like to start from scratch [y]? " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    userdel -r $LFS_USERNAME
    groupdel $LFS_GROUPNAME
    rm -rf $LFS_ROOT_BACKUP_FOLDER
    rm -rf $LFS_ROOT_BACKUP_LOGS/*build-logs
  fi
fi

echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please note that $LFS_PARTITION_ROOT and $LFS_PARTITION_SWAP will be formated."
read -p "Are you sure? " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 0
fi

echo  "... Formatting Root Partition On $LFS_PARTITION_ROOT"
mkfs -t ext4 $LFS_PARTITION_ROOT

echo  "... Formatting Swap Drive On $LFS_PARTITION_SWAP"
mkswap $LFS_PARTITION_SWAP

echo ""
echo "######### END OF CHAPTER 2.3 #########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./2.4-root_set-lfs-variable.sh"
echo ""

exit 0
