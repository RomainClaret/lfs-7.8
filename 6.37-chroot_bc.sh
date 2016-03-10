#!/bin/bash

CHAPTER_SECTION=37
INSTALL_NAME=bc

echo ""
echo "### ---------------------------"
echo "###              BC         ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Bc-1.06.95"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real	0m19.113s"
echo "### user	0m15.589s"
echo "### sys	  0m0.780s"
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
is_user root
check_chroot

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME
cd /sources
check_tarball_uniqueness
extract_tarball
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring $SOURCE_FILE_NAME"
  patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch &> $LOG_FILE-patch.log

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure                 \
    --prefix=/usr             \
    --with-readline           \
    --mandir=/usr/share/man   \
    --infodir=/usr/share/info \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Checking $SOURCE_FILE_NAME"
  echo "quit" | ./bc/bc -l Test/checklib.b &> $LOG_FILE-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)
get_build_errors_6

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.38-chroot_libtool.sh"
echo ""

exit 0
