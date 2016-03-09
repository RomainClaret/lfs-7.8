#!/tools/bin/bash

CHAPTER_SECTION=18
INSTALL_NAME=bzip

echo ""
echo "### ---------------------------"
echo "###             BZIP2       ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Bzip2-1.0.6"
echo "### Must be run as \"chroot\" user"
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
  patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch &> $LOG_FILE-patch.log
	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
	make -f Makefile-libbz2_so &> $LOG_FILE-make-makefile-libbz2.log
	make clean &> $LOG_FILE-make-clean.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make PREFIX=/usr install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  cp -v bzip2-shared /bin/bzip2 &> $LOG_FILE-post-make.log
	cp -av libbz2.so* /lib &>> $LOG_FILE-post-make.log
	ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so &>> $LOG_FILE-post-make.log
	rm -v /usr/bin/{bunzip2,bzcat,bzip2} &>> $LOG_FILE-post-make.log
	ln -sv bzip2 /bin/bunzip2 &>> $LOG_FILE-post-make.log
	ln -sv bzip2 /bin/bzcat &>> $LOG_FILE-post-make.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.19-chroot_pkg-config.sh"
echo ""

exit 0
