#!/bin/bash

CHAPTER_SECTION=54
INSTALL_NAME=grub

echo ""
echo "### ---------------------------"
echo "###            GRUB         ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### GRUB-2.02~beta2"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real	1m55.334s"
echo "### user	1m8.972s"
echo "### sys	  0m14.765s"
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
BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME
cd /sources
check_tarball_uniqueness
extract_tarball
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring $SOURCE_FILE_NAME"
  sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure              \
    --prefix=/usr          \
    --sbindir=/sbin        \
    --sysconfdir=/etc      \
    --disable-grub-emu-usb \
    --disable-efiemu       \
    --disable-werror       \
    &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

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
echo "### ./6.55-chroot_less.sh"
echo ""

exit 0
