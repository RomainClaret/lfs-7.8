#!/bin/bash

CHAPTER_SECTION=43
INSTALL_NAME=XML-Parser

echo ""
echo "### ---------------------------"
echo "###         XML-PARSER      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### XML::Parser-2.44"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real  0m2.966s"
echo "### user  0m2.444s"
echo "### sys   0m0.300s"
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
  perl Makefile.PL

  echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make test $PROCESSOR_CORES &> $LOG_FILE-make-test.log

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
echo "### ./6.44-chroot_autoconf.sh"
echo ""

exit 0
