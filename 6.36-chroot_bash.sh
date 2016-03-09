#!/tools/bin/bash

CHAPTER_SECTION=36
INSTALL_NAME=bash

echo ""
echo "### ---------------------------"
echo "###             BASH        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Bash-4.3.30"
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
cd /sources
check_tarball_uniqueness
extract_tarball
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring $SOURCE_FILE_NAME"
  patch -Np1 -i ../bash-4.3.30-upstream_fixes-2.patch &> $LOG_FILE-patch.log

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure                           \
    --prefix=/usr                       \
    --bindir=/bin                       \
    --docdir=/usr/share/doc/bash-4.3.30 \
    --without-bash-malloc               \
    --with-installed-readline           \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  chown -Rv nobody . &> $LOG_FILE-make-check.log
  su nobody -s /bin/bash -c "PATH=$PATH make tests" &>> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next steps:"
echo "### cd /root/lfs"
echo "### ./6.37-chroot_bc.sh"
echo ""

exec /bin/bash --login +h
