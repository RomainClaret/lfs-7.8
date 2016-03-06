#!/bin/bash

CHAPTER_SECTION=35
INSTALL_NAME=stripping

echo ""
echo "### ---------------------------"
echo "###         STRIPPING       ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### Stripping"
echo "### Must be run as \"lfs\" user"
echo "### ---------------------------"

BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5.$CHAPTER_SECTION_$INSTALL_NAME

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
init_tarball
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Configuring $SOURCE_FILE_NAME"
  strip --strip-debug /tools/lib/* &> $LOG_FILE-debugs.log
  /usr/bin/strip --strip-unneeded /tools/{,s}bin/* &> $LOG_FILE-unneeded.log
  rm -rf /tools/{,share}/{info,man,doc} &> $LOG_FILE-info-man_doc-files.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors $LFS_MOUNT

echo ""
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "Read carefully the following instructions"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### exit"
echo "### ./5.36-lfs_changing-ownership.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
