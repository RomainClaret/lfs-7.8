#!/tools/bin/bash

CHAPTER_SECTION=70
INSTALL_NAME=vim

echo ""
echo "### ---------------------------"
echo "###            VIM          ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Vim-7.4"
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
  echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

  echo ".... Configuring $SOURCE_FILE_NAME"
  ./configure     \
    --prefix=/usr \
    &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES test &> $LOG_FILE-make-check.log

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  ln -sv vim /usr/bin/vi
	for L in /usr/share/man/{,*/}man1/vim.1; do
	 ln -sv vim.1 $(dirname $L)/vi.1
	done
	ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4
	cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc
set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
 set background=dark
endif
" End /etc/vimrc
EOF

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.72-chroot_stripping.sh"
echo ""

exit 0
