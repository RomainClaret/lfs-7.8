#!/bin/bash
echo ""
echo "### --------------------------------"
echo "###     PACKAGES AND PATCHES     ###"
echo "###         CHAPTER 3.ALL        ###"
echo "### Downloading packages and patches"
echo "### Must be run as \"root\""
echo "### --------------------------------"

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
check_partitions
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

if [ ! -d "$LFS_MOUNT/sources" ]
then
  echo "... Creating $LFS_MOUNT/sources"
  mkdir $LFS_MOUNT/sources
  chmod a+wt $LFS_MOUNT/sources
else
  echo "... Reseting $LFS_MOUNT/sources"
  rm -rf $LFS_MOUNT/sources
  mkdir $LFS_MOUNT/sources
  chmod a+wt $LFS_MOUNT/sources
fi

if [ ! -d $LFS_BACKUPS ]
then
  echo "... Creating the backup folder"
  mkdir -p $LFS_BACKUPS
else
  echo "... Checking the health of the backup folder"
fi
backupVolume=$(ls -1 $LFS_BACKUPS | wc -l)

if [ $backupVolume -eq $LFS_OFFICIAL_78_PACKAGES_NUMBER ]
then
  echo "... Backup folder is healthy, tranfert of $LFS_BACKUPS to $LFS_MOUNT/sources"
  cp -r $LFS_BACKUPS/* $LFS_MOUNT/sources
else
  echo "... Backup folder is unhealthy or incomplete, reset and download of packages"
  wget -nc $LFS_OFFICIAL_78_PACKAGES_LIST -P $LFS_MOUNT/sources
  wget -nc $LFS_OFFICIAL_78_PACKAGES_MD5 -P $LFS_MOUNT/sources
  wget -nc -i $LFS_MOUNT/sources/wget-list -P $LFS_MOUNT/sources
  echo "... Backing up the sources to $LFS_BACKUPS"
  rm -rf $LFS_BACKUPS
  mkdir -p $LFS_BACKUPS
  cp -r $LFS_MOUNT/sources/* $LFS_BACKUPS
fi

echo ""
echo "... Checksum verification"
pushd  $LFS_MOUNT/sources
md5sum -c $LFS_MOUNT/sources/md5sums
popd

echo ""
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please follow the instructions bellow:"
echo "### Verify that the MD5 checksums above match"
echo "### Also cross check with the book 7.8"
echo ""
read -p "Enter to confirm" -n 1 -r
echo ""
echo "######### END OF CHAPTER 3.ALL ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./4.2-root_create-lfs-tools-directory.sh"
echo ""

exit 0
