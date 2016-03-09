#!/tools/bin/bash

CHAPTER_SECTION=27
INSTALL_NAME=procps-ng

echo ""
echo "### ---------------------------"
echo "###          PROCPS-NG      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Procps-ng-3.3.11"
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

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure
    --prefix=/usr                            \
    --exec-prefix=                           \
    --libdir=/usr/lib                        \
    --docdir=/usr/share/doc/procps-ng-3.3.11 \
    --disable-static                         \
    --disable-kill                           \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log
  sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/lib/libprocps.so.* /lib
	ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.28-chroot_e2fsprogs.sh"
echo ""

exit 0
