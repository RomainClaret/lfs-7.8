#!/bin/bash

CHAPTER_SECTION=29
INSTALL_NAME=perl

echo ""
echo "### ---------------------------"
echo "###            PERL         ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### Perl-5.22.0"
echo "### Must be run as \"lfs\" user"
echo ""
echo "### Time estimate:"
echo "### real	2m53.399s"
echo "### user	2m25.165s"
echo "### sys	  0m11.913s"
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
check_partitions
is_user lfs
check_tools

echo ""
echo "... Setup building environment"
BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5$CHAPTER_SECTION-$INSTALL_NAME
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Configuring $SOURCE_FILE_NAME"
  sh Configure      \
    -des            \
    -Dprefix=/tools \
    -Dlibs=-lm      \
	  &> $LFS_LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  cp -v perl cpan/podlators/pod2man /tools/bin &> $LOG_FILE-postinstall-copy-podlators.log
	mkdir -pv /tools/lib/perl5/5.22.0 &> $LOG_FILE-postinstall-mkdir-5.20.log
	cp -Rv lib/* /tools/lib/perl5/5.22.0 &> $LOG_FILE-postinstall-copy-lib.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.30-lfs_sed-4.2.2.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
