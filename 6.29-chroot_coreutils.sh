#!/tools/bin/bash

CHAPTER_SECTION=29
INSTALL_NAME=coreutils

echo ""
echo "### ---------------------------"
echo "###          COREUTILS      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Coreutils-8.24"
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
  patch -Np1 -i ../coreutils-8.24-i18n-1.patch &> $LOG_FILE-patch.log
	sed -i '/tests\/misc\/sort.pl/ d' Makefile.in

  echo ".... Configuring $SOURCE_FILE_NAME"
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix=/usr            \
    --enable-no-install-program=kill,uptime \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make NON_ROOT_USERNAME=nobody check-root &>> $LOG_FILE-make-check.log
  echo "dummy:x:1000:nobody" >> /etc/group
	chown -Rv nobody . &>> $LOG_FILE-make-check.log
	su nobody -s /bin/bash -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check" &>> $LOG_FILE-make-check.log
	sed -i '/dummy/d' /etc/group

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin 	&> $LOG_FILE-post-install.log
	mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin	&>> $LOG_FILE-post-install.log
	/bin/mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin	&>> $LOG_FILE-post-install.log
	/bin/mv -v /usr/bin/chroot /usr/sbin &>> $LOG_FILE-post-install.log
	/bin/mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8 &>> $LOG_FILE-post-install.log
	sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8	&>> $LOG_FILE-post-install.log
	/bin/mv -v /usr/bin/{head,sleep,nice,test,[} /bin &>> $LOG_FILE-post-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.30-chroot_iana-etc.sh"
echo ""

exit 0
