#!/bin/bash

CHAPTER_SECTION=10
INSTALL_NAME=gcc

echo ""
echo "### ---------------------------"
echo "###             GCC         ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION     ###"
echo "### GCC-5.2.0 - Pass 2"
echo "### Must be run as \"lfs\" user"
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
is_user lfs
check_tools

echo ""
echo "... Setup building environment"
BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5$CHAPTER_SECTION-$INSTALL_NAME
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Pre-Configuring"
  cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h
  for file in \
	 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
	  cp -uv $file{,.orig}
	  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
		  -e 's@/usr@/tools@g' $file.orig > $file
	  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	  touch $file.orig
	done

	tar -xf ../mpfr-3.1.3.tar.xz
	mv -v mpfr-3.1.3 mpfr
	tar -xf ../gmp-6.0.0a.tar.xz
	mv -v gmp-6.0.0 gmp
	tar -xf ../mpc-1.0.3.tar.gz
	mv -v mpc-1.0.3 mpc

	mkdir ../$BUILD_DIRECTORY
	cd ../$BUILD_DIRECTORY

	echo ".... Configuring $SOURCE_FILE_NAME"
  CC=$LFS_TGT-gcc                                  \
	CXX=$LFS_TGT-g++                                 \
	AR=$LFS_TGT-ar                                   \
	RANLIB=$LFS_TGT-ranlib                           \
	../gcc-5.2.0/configure                           \
		--prefix=/tools                                \
		--with-local-prefix=/tools                     \
		--with-native-system-header-dir=/tools/include \
		--enable-languages=c,c++                       \
		--disable-libstdcxx-pch                        \
		--disable-multilib                             \
		--disable-bootstrap                            \
		--disable-libgomp								\
		&> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
	make $PROCESSOR_CORES &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
	make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  ln -sv gcc /tools/bin/cc &> $LOG_FILE-make-symlink-for-gcc.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors

echo ""
echo "configure: WARNING:"
echo "### These auxiliary programs are missing or"
echo "### incompatible versions: msgfmt"
echo "### some features will be disabled."
echo "### Check the INSTALL file for required versions."
echo ""
echo -e "\a"
read -p "Enter to start test" -n 1 -r
echo ""

echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'

echo ""
echo "ABOVE should be without errors and with the same output than below"
echo "32bit: [Requesting program interpreter: /tools/lib/ld-linux.so.2]"
echo "64bit: [Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

rm -v dummy.c a.out

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "### Warning Counter: $WARNINGS_COUNTER"
echo "### Error Counter: $ERRORS_COUNTER"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.11-lfs_tcl-core-8.6.4.sh"
echo ""

if [ $ERRORS_COUNTER -ne 0 ]
then
	exit 6
else
	exit 0
fi
