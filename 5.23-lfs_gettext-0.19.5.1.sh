#!/bin/bash

CHAPTER_SECTION=23
INSTALL_NAME=gettext

echo ""
echo "### ---------------------------"
echo "###          GETTEXT        ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### Gettext-0.19.5.1"
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

  echo ".... Pre-Configuring"
  cd gettext-tools

	echo ".... Configuring $SOURCE_FILE_NAME"
  EMACS="no" ./configure  \
    --prefix=/tools       \
    --disable-shared      \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make -C gnulib-lib $PROCESSOR_CORES &> $LOG_FILE-make-gnulib-lib.log
	make -C intl pluralx.c &> $LOG_FILE-make-pluralx.log
	make -C src msgfmt $PROCESSOR_CORES &> $LOG_FILE-make-src-msgfmt.log
	make -C src msgmerge $PROCESSOR_CORES &> $LOG_FILE-make-src-msgmerge.log
	make -C src xgettext $PROCESSOR_CORES &> $LOG_FILE-make-src-xgettext.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors $LFS_MOUNT

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.24-lfs_grep-2.21.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
