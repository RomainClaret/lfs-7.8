#!/tools/bin/bash

CHAPTER_SECTION=57
INSTALL_NAME=iproute

echo ""
echo "### ---------------------------"
echo "###         IPROUTE      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### IPRoute2-3.19.0"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real	time"
echo "### user	time"
echo "### sys	  time"
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
  sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
	sed -i /ARPD/d Makefile
	sed -i 's/arpd.8//' man/man8/Makefile

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make DOCDIR=/usr/share/doc/iproute2-4.2.0 install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.58-chroot_kbd.sh"
echo ""

exit 0
