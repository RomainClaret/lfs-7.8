#!/bin/bash

CHAPTER_SECTION=5
INSTALL_NAME=gcc

echo ""
echo "### ---------------------------"
echo "###            GCC          ###"
echo "###        CHAPTER 5.5      ###"
echo "### GCC-5.2.0 - Pass 1"
echo "### Must be run as \"lfs\" user"
echo "### ---------------------------"

BUILD_DIRECTORY=$INSTALL_NAME-build
LOG_FILE=$LFS_BUILD_LOGS_5.$CHAPTER_SECTION_$INSTALL_NAME

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
cd $LFS_MOUNT_SOURCES
check_tarball_uniqueness
init_tarball $LFS_MOUNT_SOURCES
cd $(ls -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)

echo ""
echo "... Installation starts now"
time {

	echo ".... Pre-Configuring"
  tar -xf ../mpfr-3.1.3.tar.xz
	mv -v mpfr-3.1.3 mpfr					&> $LOG_FILE-mv-mpfr.log
	tar -xf ../gmp-6.0.0a.tar.xz
	mv -v gmp-6.0.0 gmp						&> $LOG_FILE-mv-gmp.log
	tar -xf ../mpc-1.0.3.tar.gz
	mv -v mpc-1.0.3 mpc						&> $LOG_FILE-mv-mpc.log

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

	sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

  mkdir ../$BUILD_DIRECTORY
  cd ../$BUILD_DIRECTORY

	echo ".... Configuring $SOURCE_FILE_NAME"
  ../gcc-5.2.0/configure                           \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++                       \
		&> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
	make $PROCESSOR_CORES \
	  &> $LOG_FILE-make.log

	echo ".... Installing $SOURCE_FILE_NAME"
	make install $PROCESSOR_CORES \
	  &> $LOG_FILE-make-install.log

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd $LFS_MOUNT_SOURCES
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d  $LFS_MOUNT_SOURCES/$INSTALL_NAME*/)
rm -rf $BUILD_DIRECTORY

get_build_errors

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.5-lfs_gcc-5.2.0.sh"
echo ""

if [ $LFS_ERROR_COUNT -ne 0 ]; then
	exit 6
else
	exit 0
fi
