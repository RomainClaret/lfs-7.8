#!/bin/bash

CHAPTER_SECTION=17
INSTALL_NAME=gcc

echo ""
echo "### ---------------------------"
echo "###             GCC         ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### GCC-5.2.0"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real  235m26.724s ~= 4h"
echo "### user  212m30.493s"
echo "### sys   22m7.003s"
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
BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME
cd /sources
check_tarball_uniqueness
extract_tarball
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

  echo ".... Pre-Configuring $SOURCE_FILE_NAME"
  mkdir ../$BUILD_DIRECTORY
  cd ../$BUILD_DIRECTORY

  echo ".... Configuring $SOURCE_FILE_NAME"
  SED=sed                     \
  ../gcc-5.2.0/configure      \
    --prefix=/usr             \
    --enable-languages=c,c++  \
    --disable-multilib        \
    --disable-bootstrap       \
    --with-system-zlib        \
    &> $LOG_FILE-configure.log

  echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  ulimit -s 32768
  make -k check $PROCESSOR_CORES &> $LOG_FILE-make-check.log
  ../gcc-4.9.2/contrib/test_summary &> $LOG_FILE-test-summary.log

  echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  ln -sv ../usr/bin/cpp /lib
  ln -sv gcc /usr/bin/cc
  install -v -dm755 /usr/lib/bfd-plugins
  ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/5.2.0/liblto_plugin.so /usr/lib/bfd-plugins/

}

echo ".... Sanity Checking"

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

echo ""
echo "ABOVE should be the same output than below"
echo "32bit: [Requesting program interpreter: /lib/ld-linux.so.2]"
echo "64bit: [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

echo ""
echo "ABOVE should be the same output than below"
echo "32bit:"
echo "### /usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crt1.o succeeded"
echo "### /usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crti.o succeeded"
echo "### /usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crtn.o succeeded"
echo "64bit:"
echo "### /usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../lib64/crt1.o succeeded"
echo "### /usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../lib64/crti.o succeeded"
echo "### /usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../lib64/crtn.o succeeded"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

grep -B4 '^ /usr/include' dummy.log

echo ""
echo "ABOVE should be the same output than below"
echo "32bit:"
echo "### #include <...> search starts here:"
echo "### /usr/lib/gcc/i686-pc-linux-gnu/5.2.0/include"
echo "### /usr/local/include"
echo "### /usr/lib/gcc/i686-pc-linux-gnu/5.2.0/include-fixed"
echo "### /usr/include"
echo "64bit:"
echo "### #include <...> search starts here:"
echo "### /usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/include"
echo "### /usr/local/include"
echo "### /usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/include-fixed"
echo "### /usr/include"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

echo ""
echo "ABOVE should be the same output than below"
echo "32bit:"
echo 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib32")'
echo 'SEARCH_DIR("/usr/local/lib32")'
echo 'SEARCH_DIR("/lib32")'
echo 'SEARCH_DIR("/usr/lib32")'
echo 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib")'
echo 'SEARCH_DIR("/usr/local/lib")'
echo 'SEARCH_DIR("/lib")'
echo 'SEARCH_DIR("/usr/lib");'
echo "64bit:"
echo '### SEARCH_DIR("/usr/x86_64-unknown-linux-gnu/lib64")'
echo '### SEARCH_DIR("/usr/local/lib64")'
echo '### SEARCH_DIR("/lib64")'
echo '### SEARCH_DIR("/usr/lib64")'
echo '### SEARCH_DIR("/usr/x86_64-unknown-linux-gnu/lib")'
echo '### SEARCH_DIR("/usr/local/lib")'
echo '### SEARCH_DIR("/lib")'
echo '### SEARCH_DIR("/usr/lib");'
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

grep "/lib.*/libc.so.6 " dummy.log

echo ""
echo "ABOVE should be the same output than below"
echo "32bit: attempt to open /lib/libc.so.6 succeeded"
echo "64bit: attempt to open /lib64/libc.so.6 succeeded"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

grep found dummy.log

echo ""
echo "ABOVE should be the same output than below"
echo "32bit: found ld-linux.so.2 at /lib/ld-linux.so.2"
echo "64bit: found ld-linux-x86-64.so.2 at /lib64/ld-linux-x86-64.so.2"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

echo ".... Finishing"
rm -v dummy.c a.out dummy.log
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)
get_build_errors_6

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.18-chroot_bzip2.sh"
echo ""

exit
