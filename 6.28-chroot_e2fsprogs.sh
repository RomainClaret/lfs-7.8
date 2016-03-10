#!/bin/bash

CHAPTER_SECTION=28
INSTALL_NAME=e2fsprogs

echo ""
echo "### ---------------------------"
echo "###          E2FSPROGS      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### E2fsprogs-1.42.13"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real	6m1.188s"
echo "### user	3m56.951s"
echo "### sys	  0m7.932s"
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
  mkdir -v build
	cd build

  echo ".... Configuring $SOURCE_FILE_NAME"
  LIBS=-L/tools/lib                    \
	CFLAGS=-I/tools/include              \
	PKG_CONFIG_PATH=/tools/lib/pkgconfig \
	../configure                         \
    --prefix=/usr                      \
    --bindir=/bin                      \
    --with-root-prefix=""              \
    --enable-elf-shlibs                \
    --disable-libblkid                 \
    --disable-libuuid                  \
    --disable-uuidd                    \
    --disable-fsck				             \
    &> $LOG_FILE-config.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log
  ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make LD_LIBRARY_PATH=/tools/lib check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
	gunzip -v /usr/share/info/libext2fs.info.gz
	install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
	makeinfo -o doc/com_err.info ../lib/et/com_err.texinfo
	install -v -m644 doc/com_err.info /usr/share/info
	install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

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
echo "### ./6.29-chroot_coreutils.sh"
echo ""

exit
