#!/bin/bash

CHAPTER_SECTION=7
INSTALL_NAME=glibc

echo ""
echo "### ---------------------------"
echo "###           Glibc         ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION      ###"
echo "### Glibc-2.22"
echo "### Must be run as \"lfs\" user"
echo ""
echo "### Time estimate:"
echo "### real	14m54.298s"
echo "### user	11m45.084s"
echo "### sys	  1m39.134s"
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
  patch -Np1 -i ../glibc-2.22-upstream_i386_fix-1.patch &> $LOG_FILE-patch.log

	mkdir ../$BUILD_DIRECTORY
	cd ../$BUILD_DIRECTORY

	echo ".... Configuring $SOURCE_FILE_NAME"
  ../glibc-2.22/configure                           \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.22/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes                         \
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

get_build_errors_5

echo ""
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'

echo ""
echo "ABOVE should be without errors and with the same output than below"
echo "32bit: [Requesting program interpreter: /tools/lib/ld-linux.so.2]"
echo "64bit: [Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

rm $LFS_MOUNT_SOURCES/dummy.c $LFS_MOUNT_SOURCES/a.out

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.8-lfs_libstdcpp-5.2.0.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
