#!/bin/bash

CHAPTER_SECTION=5
INSTALL_NAME=create-dirs

echo ""
echo "### ---------------------------"
echo "###   CREATING DIRECTORIES  ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Creating Directories"
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
check_partitions
check_chroot

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Creating the initial directories and children: /bin /boot /etc /usr" | tee $LOG_FILE
mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt} &>> $LOG_FILE
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var} &>> $LOG_FILE
install -dv -m 0750 /root &>> $LOG_FILE
install -dv -m 1777 /tmp /var/tmp &>> $LOG_FILE
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src} &>> $LOG_FILE
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man} &>> $LOG_FILE
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo} &>> $LOG_FILE
mkdir -v  /usr/libexec &>> $LOG_FILE
mkdir -pv /usr/{,local/}share/man/man{1..8} &>> $LOG_FILE

echo "... Processing for x86_64 processors" | tee -a $LOG_FILE
case $(uname -m) in
x86_64) ln -sv lib /lib64
  ln -sv lib /usr/lib64 &>> $LOG_FILE
  ln -sv lib /usr/local/lib64 &>> $LOG_FILE
  ;;
esac

echo "*** Creating /var directory and sub directories."	| tee -a $LOG_FILE
mkdir -v /var/{log,mail,spool} &>> $LOG_FILE
ln -sv /run /var/run &>> $LOG_FILE
ln -sv /run/lock /var/lock &>> $LOG_FILE
mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local} &>> $LOG_FILE

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next steps:"
echo "### mv /tools/lfs /root/lfs"
echo "### cd /root/lfs"
echo "### ./6.6-chroot_essentials.sh"
echo ""

exit 0
