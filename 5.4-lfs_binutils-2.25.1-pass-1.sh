#!/bin/bash

CHAPTER_SECTION=4
INSTALL_NAME=binutils

echo ""
echo "### ---------------------------"
echo "###          BINUTILS       ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION      ###"
echo "### Binutils-2.25.1 - Pass 1"
echo "### Must be run as \"lfs\" user"
echo ""
echo "### Time estimate:"
echo "### real  2m51.460s"
echo "### user  2m3.596s"
echo "### sys   0m15.765s"
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
echo $LOG_FILE
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring"
  mkdir ../$BUILD_DIRECTORY
  cd ../$BUILD_DIRECTORY

  echo ".... Configuring $SOURCE_FILE_NAME"
  ../binutils-2.25.1/configure \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror           \
    &> $LOG_FILE-configure.log

  echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  case $(uname -m) in x86_64)
    echo "---> 64bit architecture detected"
    mkdir /tools/lib && ln -sv lib /tools/lib64 ;;
  esac

  echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors_5

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.5-lfs_gcc-5.2.0-pass-1.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
  exit 6
else
  exit 0
fi
