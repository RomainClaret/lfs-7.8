#!/tools/bin/bash

CHAPTER_SECTION=35
INSTALL_NAME=readline

echo ""
echo "### ---------------------------"
echo "###          READLINE       ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Readline-6.3"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real	0m9.376s"
echo "### user	0m5.812s"
echo "### sys	  0m1.204s"
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
  patch -Np1 -i ../readline-6.3-upstream_fixes-3.patch &> $LOG_FILE-patch.log
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure                            \
    --prefix=/usr                        \
    --disable-static                     \
    --docdir=/usr/share/doc/readline-6.3 \
	  &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make SHLIB_LIBS=-lncurses $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make SHLIB_LIBS=-lncurses install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Installing HTML $SOURCE_FILE_NAME"
  make install-html $PROCESSOR_CORES &> $LOG_FILE-make-install-html.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  mv -v /usr/lib/lib{readline,history}.so.* /lib &> $LOG_FILE-post-install.log
	ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so &>> $LOG_FILE-post-install.log
	ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so &>> $LOG_FILE-post-install.log
	install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-6.3 &>> $LOG_FILE-post-install.log

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
echo "### ./6.36-chroot_bash.sh"
echo ""

exit 0
