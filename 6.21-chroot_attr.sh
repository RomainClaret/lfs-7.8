#!/tools/bin/bash

CHAPTER_SECTION=21
INSTALL_NAME=attr

echo ""
echo "### ---------------------------"
echo "###             ATTR        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Attr-2.4.47"
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
  sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
	sed -i -e "/SUBDIRS/s|man2||" man/Makefile

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure        \
    --prefix=/usr    \
    --bindir=/bin    \
    --disable-static \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make -j1 tests root-tests &> $LOG_FILE-make-tests.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install install-dev install-lib $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  chmod -v 755 /usr/lib/libattr.so
	mv -v /usr/lib/libattr.so.* /lib
	ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.22-chroot_acl.sh"
echo ""

exit
