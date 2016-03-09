#!/tools/bin/bash

CHAPTER_SECTION=9
INSTALL_NAME=glibc

echo ""
echo "### ---------------------------"
echo "###            GLIBC        ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Glibc-2.22"
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
  patch -Np1 -i ../glibc-2.22-fhs-1.patch &> $LOG_FILE-patch1.log
  patch -Np1 -i ../glibc-2.22-upstream_i386_fix-1.patch &> $LOG_FILE-patch2.log

  mkdir ../$BUILD_DIRECTORY
  cd ../$BUILD_DIRECTORY

  echo ".... Configuring $SOURCE_FILE_NAME"
  ../glibc-2.22/configure  \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=2.6.32 \
    --enable-obsolete-rpc  \
    &> $LOG_FILE-configure.log

	echo ".... Making $SOURCE_FILE_NAME"
  make $PROCESSOR_CORES &> $LOG_FILE-make.log

  echo ".... Make Checking $SOURCE_FILE_NAME"
  make check $PROCESSOR_CORES &> $LOG_FILE-make-check.log
  touch /etc/ld.so.conf

	echo ".... Installing $SOURCE_FILE_NAME"
  make install $PROCESSOR_CORES &> $LOG_FILE-make-install.log

  echo ".... Post-Installing $SOURCE_FILE_NAME"
  cp -v ../glibc-2.22/nscd/nscd.conf /etc/nscd.conf
  mkdir -pv /var/cache/nscd
  mkdir -pv /usr/lib/locale
  localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
  localedef -i de_DE -f ISO-8859-1 de_DE
  localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
  localedef -i de_DE -f UTF-8 de_DE.UTF-8
  localedef -i en_GB -f UTF-8 en_GB.UTF-8
  localedef -i en_HK -f ISO-8859-1 en_HK
  localedef -i en_PH -f ISO-8859-1 en_PH
  localedef -i en_US -f ISO-8859-1 en_US
  localedef -i en_US -f UTF-8 en_US.UTF-8
  localedef -i es_MX -f ISO-8859-1 es_MX
  localedef -i fa_IR -f UTF-8 fa_IR
  localedef -i fr_FR -f ISO-8859-1 fr_FR
  localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
  localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
  localedef -i it_IT -f ISO-8859-1 it_IT
  localedef -i it_IT -f UTF-8 it_IT.UTF-8
  localedef -i ja_JP -f EUC-JP ja_JP
  localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
  localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
  localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
  localedef -i zh_CN -f GB18030 zh_CN.GB18030

  make localedata/install-locales &> $LOG_FILE-make-locales.log

  echo "---> Configuring Glibc"
  cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf
passwd: files
group: files
shadow: files
hosts: files dns
networks: files
protocols: files
services: files
ethers: files
rpc: files
# End /etc/nsswitch.conf
EOF

  tar -xf ../tzdata2015f.tar.gz
  ZONEINFO=/usr/share/zoneinfo
  mkdir -pv $ZONEINFO/{posix,right}
  for tz in etcetera southamerica northamerica europe africa antarctica  \
            asia australasia backward pacificnew systemv; do
      zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
      zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
      zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
  done
  cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
  zic -d $ZONEINFO -p America/New_York
  unset ZONEINFO

  cp -v /usr/share/zoneinfo/$LFS_TIME_ZONE /etc/localtime

  echo "---> Configuring the Dynamic Loader"

  cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib
EOF

  cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf
EOF

  mkdir -pv /etc/ld.so.conf.d

  }

}

echo ""
echo "... Cleaning up $SOURCE_FILE_NAME"
cd /sources
[ ! $SHOULD_NOT_CLEAN ] && rm -rf $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.10-chroot_toolchain.sh"
echo ""

exit
