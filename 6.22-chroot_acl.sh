#!/bin/bash

CHAPTER_SECTION=22
INSTALL_NAME=acl

echo ""
echo "### ---------------------------"
echo "###              ACL        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Acl-2.2.52"
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
check_user root
check_partitions
check_chroot

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME
cd /sources
test_only_one_tarball_exists
extract_tarball ""
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring $SOURCE_FILE_NAME"
  sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
	sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
	sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" libacl/__acl_to_any_text.c

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure
    --prefix=/usr    \
    --bindir=/bin    \
    --disable-static \
    --libexecdir=/usr/lib \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install install-dev install-lib $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  chmod -v 755 /usr/lib/libacl.so &> $LOG_FILE-post-install.log
	mv -v /usr/lib/libacl.so.* /lib &>> $LOG_FILE-post-install.log
	ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so &>> $LOG_FILE-post-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.23-chroot_libcap.sh"
echo ""

exit 0
