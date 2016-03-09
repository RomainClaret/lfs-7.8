#!/bin/bash

CHAPTER_SECTION=8
INSTALL_NAME=gcc

echo ""
echo "### ---------------------------"
echo "###          Libstdc       ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION      ###"
echo "### Libstdc++-5.2.0"
echo "### Must be run as \"lfs\" user"
echo ""
echo "### Time estimate:"
echo "### real	1m9.437s"
echo "### user	0m47.307s"
echo "### sys	  0m7.916s"
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

	echo ".... Pre-Configuring"
	mkdir ../$BUILD_DIRECTORY
	cd ../$BUILD_DIRECTORY

	echo ".... Configuring $SOURCE_FILE_NAME"
  ../gcc-5.2.0/libstdc++-v3/configure                        \
    --host=$LFS_TGT                                          \
    --prefix=/tools                                          \
    --disable-multilib                                       \
    --disable-nls                                            \
    --disable-libstdcxx-threads                              \
    --disable-libstdcxx-pch                                  \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/5.2.0 \
		&> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
	make $PROCESSOR_CORES &> $LOG_FILE-make.log

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
echo "### ./5.9-lfs_binutils-2.25.1-pass-2.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
