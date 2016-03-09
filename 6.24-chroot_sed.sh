#!/tools/bin/bash

CHAPTER_SECTION=24
INSTALL_NAME=sed

echo ""
echo "### ---------------------------"
echo "###              SED        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Sed-4.2.2"
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
  ./configure                          \
    --prefix=/usr                      \
    --bindir=/bin                      \
    --htmldir=/usr/share/doc/sed-4.2.2 \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Making HTML $SOURCE_FILE_NAME"
  make html $PROCESSOR_CORES &> $LOG_FILE-make-html.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Installing HTML $SOURCE_FILE_NAME"
  make -C doc install-html $PROCESSOR_CORES &> $LOG_FILE-make-install-html.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.25-chroot_shadow.sh"
echo ""

exit 0
