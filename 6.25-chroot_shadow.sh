#!/tools/bin/bash

CHAPTER_SECTION=25
INSTALL_NAME=shadow

echo ""
echo "### ---------------------------"
echo "###            SHADOW       ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Shadow-4.2.1"
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
  sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
	sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
	       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
	sed -i 's/1000/999/' etc/useradd

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure --sysconfdir=/etc --with-group-name-max-length=32 \
	  &> $LFS_LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/bin/passwd /bin
	pwconv
	grpconv
	echo "root:$LFS_PASSWORD" | chpasswd

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.26-chroot_psmisc.sh"
echo ""

exit 0
