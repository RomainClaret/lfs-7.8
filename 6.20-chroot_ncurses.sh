#!/bin/bash

CHAPTER_SECTION=20
INSTALL_NAME=ncurses

echo ""
echo "### ---------------------------"
echo "###           NCURSES       ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Ncurses-6.0"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real  0m48.676s"
echo "### user  0m32.802s"
echo "### sys   0m5.680s"
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
  sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure               \
    --prefix=/usr           \
    --mandir=/usr/share/man \
    --with-shared           \
    --without-debug         \
    --without-normal        \
    --enable-pc-files       \
    --enable-widec          \
    &> $LOG_FILE-configure.log

  echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/lib/libncursesw.so.6* /lib &> $LOG_FILE-post-install.log
  ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so &>> $LOG_FILE-post-install.log

  for lib in ncurses form panel menu ; do
    rm -vf /usr/lib/lib${lib}.so &>> $LOG_FILE-post-install.log
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc &>> $LOG_FILE-post-install.log
  done

  ln -sfv libncurses++w.a /usr/lib/libncurses++.a &>> $LOG_FILE-post-install.log
  rm -vf /usr/lib/libcursesw.so &>> $LOG_FILE-post-install.log
  echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
  ln -sfv libncurses.so /usr/lib/libcurses.so
  mkdir -v /usr/share/doc/ncurses-6.0 &>> $LOG_FILE-post-install.log
  cp -v -R doc/* /usr/share/doc/ncurses-6.0 &>> $LOG_FILE-post-install.log

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
echo "### ./6.21-chroot_attr.sh"
echo ""

exit
