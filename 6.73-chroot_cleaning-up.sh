#!/tools/bin/bash

CHAPTER_SECTION=73
INSTALL_NAME=cleanup

echo ""
echo "### ---------------------------"
echo "###        CLEANING-UP      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Cleaning Up"
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
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
rm -rf /tmp/* &> $LOG_FILE-rm-temp.log
rm /usr/lib/lib{bfd,opcodes}.a &> $LOG_FILE-rm-build-libs.log
rm /usr/lib/libbz2.a &>> $LOG_FILE-rm-build-libs.log
rm /usr/lib/lib{com_err,e2p,ext2fs,ss}.a &>> $LOG_FILE-rm-build-libs.log
rm /usr/lib/libltdl.a &>> $LOG_FILE-rm-build-libs.log
rm /usr/lib/libz.a &>> $LOG_FILE-rm-build-libs.log

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./7.X-chroot_skeleton.sh"
echo ""

exit 0
