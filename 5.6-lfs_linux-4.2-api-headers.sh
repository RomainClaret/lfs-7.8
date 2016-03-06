#!/bin/bash

CHAPTER_SECTION=6
INSTALL_NAME=linux

echo ""
echo "### ---------------------------"
echo "###     Linux API HEADERS   ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION      ###"
echo "### Linux-4.2 API Headers"
echo "### Must be run as \"lfs\" user"
echo "### ---------------------------"

BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5$CHAPTER_SECTION-$INSTALL_NAME

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
echo "... Setup building environment"
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball $LFS_MOUNT_SOURCES
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Making $SOURCE_FILE_NAME"
  make mrproper $PROCESSOR_CORES &> $LOG_FILE-make-mrproper.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make INSTALL_HDR_PATH=dest headers_install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  cp -rv dest/include/* /tools/include &> $LOG_FILE-postinstall-cp-devinclude.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.7-lfs_glibc-2.22.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
