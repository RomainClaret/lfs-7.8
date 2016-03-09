#!/tools/bin/bash

CHAPTER_SECTION=41
INSTALL_NAME=inetutils

echo ""
echo "### ---------------------------"
echo "###          INETUTILS      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Inetutils-1.9.4"
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
  echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure            \
    --prefix=/usr        \
    --localstatedir=/var \
    --disable-logger     \
    --disable-whois      \
    --disable-rcp        \
    --disable-rexec      \
    --disable-rlogin     \
    --disable-rsh        \
    --disable-servers    \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
	mv -v /usr/bin/ifconfig /sbin

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.42-chroot_perl.sh"
echo ""

exit 0
