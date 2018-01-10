#!/bin/bash

CHAPTER_SECTION=68
INSTALL_NAME=util-linux

echo ""
echo "### ---------------------------"
echo "###         UTIL-LINUX      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Util-linux-2.27"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real  1m59.422s"
echo "### user  1m3.476s"
echo "### sys   0m11.521s"
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
  mkdir -pv /var/lib/hwclock

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure                               \
    ADJTIME_PATH=/var/lib/hwclock/adjtime   \
    --docdir=/usr/share/doc/util-linux-2.27 \
    --disable-chfn-chsh                     \
    --disable-login                         \
    --disable-nologin                       \
    --disable-su                            \
    --disable-setpriv                       \
    --disable-runuser                       \
    --disable-pylibmount                    \
    --disable-static                        \
    --without-python                        \
    --without-systemd                       \
    --without-systemdsystemunitdir          \
    &> $LOG_FILE-configure.log

  echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  chown -Rv nobody .
  su nobody -s /bin/bash -c "PATH=$PATH make -k check" &> $LOG_FILE-make-check.log

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
echo "### ./6.69-chroot_man-db.sh"
echo ""

exit 0
