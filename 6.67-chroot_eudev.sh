#!/tools/bin/bash

CHAPTER_SECTION=67
INSTALL_NAME=eudev

echo ""
echo "### ---------------------------"
echo "###            EUDEV        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Eudev-3.1.2"
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
  sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl
	cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure               \
    --prefix=/usr           \
    --bindir=/sbin          \
    --sbindir=/sbin         \
    --libdir=/usr/lib       \
    --sysconfdir=/etc       \
    --libexecdir=/lib       \
    --with-rootprefix=      \
    --with-rootlibdir=/lib  \
    --enable-split-usr      \
    --enable-manpages       \
    --enable-hwdb           \
    --disable-introspection \
    --disable-gudev         \
    --disable-static        \
    --config-cache          \
    --disable-gtk-doc-html  \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  LIBRARY_PATH=/tools/lib make $PROCESSOR_CORES &> $LOG_FILE-make.log
	mkdir -pv /lib/udev/rules.d
	mkdir -pv /etc/udev/rules.d

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make LD_LIBRARY_PATH=/tools/lib check $PROCESSOR_CORES &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make LD_LIBRARY_PATH=/tools/lib install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  tar -xvf ../udev-lfs-20140408.tar.bz2	&> $LOG_FILE-post-install.log
	make -f udev-lfs-20140408/Makefile.lfs install $PROCESSOR_CORES &>> $LOG_FILE-post-install.log
  LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update &>> $LOG_FILE-post-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.68-chroot_util-linux.sh"
echo ""

exit 0
