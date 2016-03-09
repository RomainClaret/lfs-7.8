#!/bin/bash

CHAPTER_SECTION=24
INSTALL_NAME=grep

echo ""
echo "### ---------------------------"
echo "###            GREP         ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### Grep-2.21"
echo "### Must be run as \"lfs\" user"
echo ""
echo "### Time estimate:"
echo "### real	0m48.392s"
echo "### user	0m23.557s"
echo "### sys	  0m5.632s"
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
echo "... Setup building environment"
BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5$CHAPTER_SECTION-$INSTALL_NAME
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure       \
    --prefix=/tools \
	  &> $LFS_LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Checking make $SOURCE_FILE_NAME"
  make check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

  echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.25-lfs_gzip-1.6.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
