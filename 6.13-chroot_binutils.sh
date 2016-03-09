#!/tools/bin/bash

CHAPTER_SECTION=13
INSTALL_NAME=binutils

echo ""
echo "### ---------------------------"
echo "###          BINUTILS       ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Binutils-2.25.1"
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
  if [ "$( expect -c 'spawn ls' | cat -v | tr -d '^M')" = "spawn ls"  ] ; then
		echo "--> Success: expect -c 'spawn ls' succeeded"
	else
		echo "!! Fatal Error 10: expect -c 'spawn ls' not working"
		exit 10
	fi

  mkdir ../$BUILD_DIRECTORY
  cd ../$BUILD_DIRECTORY

  echo ".... Configuring $SOURCE_FILE_NAME"
  ../binutils-2.25.1/configure \
    --prefix=/usr              \
    --enable-shared            \
    --disable-werror           \
    &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make tooldir=/usr $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make -k check $PROCESSOR_CORES &> $LOG_FILE-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make tooldir=/usr install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.14-chroot_gmp.sh"
echo ""

exit
