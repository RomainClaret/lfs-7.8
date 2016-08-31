#!/bin/bash

CHAPTER_SECTION=10
INSTALL_NAME=adjust-toolchain

echo ""
echo "### ---------------------------"
echo "###          TOOLCHAIN      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Adjusting the Toolchain"
echo "### Must be run as \"chroot\" user"
echo ""
echo "### Time estimate:"
echo "### real  1m5.732s"
echo "### user  0m0.020s"
echo "### sys   0m0.044s"
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
echo "... Installation starts now"
time {

  echo ".... Configuring"
  mv -v /tools/bin/{ld,ld-old}
  mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
  mv -v /tools/bin/{ld-new,ld}
  ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

  gcc -dumpspecs | sed -e 's@/tools@@g'                   \
      -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
      -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
      `dirname $(gcc --print-libgcc-file-name)`/specs

  echo ".... Sanity Checking"

  echo 'int main(){}' > dummy.c
  cc dummy.c -v -Wl,--verbose &> dummy.log
  readelf -l a.out | grep ': /lib'

  echo ""
  echo "ABOVE should be the same output than below"
  case $(uname -m) in x86_64)
    echo "64bit: [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]" ;;
  *)
    echo "32bit: [Requesting program interpreter: /lib/ld-linux.so.2]" ;;
  esac
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""

  grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

  echo ""
  echo "ABOVE should be the same output than below"
  case $(uname -m) in x86_64)
    echo "64bit:"
    echo "### /usr/lib/../lib64/crt1.o succeeded"
    echo "### /usr/lib/../lib64/crti.o succeeded"
    echo "### /usr/lib/../lib64/crtn.o succeeded" ;;
  *)
    echo "32bit:"
    echo "### /usr/lib/crt1.o succeeded"
    echo "### /usr/lib/crti.o succeeded"
    echo "### /usr/lib/crtn.o succeeded" ;;
  esac
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""

  grep -B1 '^ /usr/include' dummy.log

  echo ""
  echo "ABOVE should be the same output than below"
  echo "### #include <...> search starts here:"
  echo "### /usr/include"
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""

  grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

  echo ""
  echo "ABOVE should be the same output than below"
  case $(uname -m) in x86_64)
    echo "64bit:"
    echo '### SEARCH_DIR("=/tools/x86_64-unknown-linux-gnu/lib64")'
    echo '### SEARCH_DIR("/usr/lib")'
    echo '### SEARCH_DIR("/lib")'
    echo '### SEARCH_DIR("=/tools/x86_64-unknown-linux-gnu/lib");' ;;
  *)
    echo "32bit:"
    echo '### SEARCH_DIR("=/tools/i686-pc-linux-gnu/lib32")'
    echo '### SEARCH_DIR("/usr/lib")'
    echo '### SEARCH_DIR("/lib");'
    echo '### SEARCH_DIR("/tools/i686-pc-linux-gnu/lib")' ;;
  esac
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""

  grep "/lib.*/libc.so.6 " dummy.log

  echo ""
  echo "ABOVE should be the same output than below"
  case $(uname -m) in x86_64)
    echo "32bit: attempt to open /lib/libc.so.6 succeeded" ;;
    *)
    echo "64bit: attempt to open /lib64/libc.so.6 succeeded" ;;
  esac
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""

  grep found dummy.log

  echo ""
  echo "ABOVE should be the same output than below"
  case $(uname -m) in x86_64)
    echo "32bit: found ld-linux.so.2 at /lib/ld-linux.so.2" ;;
  *)
    echo "64bit: found ld-linux-x86-64.so.2 at /lib64/ld-linux-x86-64.so.2" ;;
  esac
  echo ""
  echo -e "\a"
  read -p "Enter to confirm" -n 1 -r
  echo ""


}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
rm -v dummy.c a.out dummy.log
get_build_errors_6

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.11-chroot_zlib.sh"
echo ""

exit
