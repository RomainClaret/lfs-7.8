#!/bin/bash

echo ""
echo "### -------------------------------"
echo "###    INSTALLING BASIC SYSTEM  ###"
echo "###         CHAPTER 6.all       ###"
echo "### Installing Basic System Software"
echo "### Must be run as \"chroot\" user"
echo "### -------------------------------"

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
check_chroot

./6.37-chroot_bc.sh
./6.38-chroot_libtool.sh
./6.39-chroot_gdbm.sh
./6.40-chroot_expat.sh
./6.41-chroot_inetutils.sh
./6.42-chroot_perl.sh
./6.43-chroot_xml-parser.sh
./6.44-chroot_autoconf.sh
./6.45-chroot_automake.sh
./6.46-chroot_diffutils.sh
./6.47-chroot_gawk.sh
./6.48-chroot_findutils.sh
./6.49-chroot_gettext.sh
./6.50-chroot_intltool.sh
./6.51-chroot_gperf.sh
./6.52-chroot_groff.sh
./6.53-chroot_xz.sh
./6.54-chroot_grub.sh
./6.55-chroot_less.sh
./6.56-chroot_gzip.sh
./6.57-chroot_iproute2.sh
./6.58-chroot_kbd.sh
./6.59-chroot_kmod.sh
./6.60-chroot_libpipeline.sh
./6.61-chroot_make.sh
./6.62-chroot_patch.sh
./6.63-chroot_sysklogd.sh
./6.64-chroot_sysvinit.sh
./6.65-chroot_tar.sh
./6.66-chroot_texinfo.sh
./6.67-chroot_eudev.sh
./6.68-chroot_util-linux.sh
./6.69-chroot_man-db.sh
./6.70-chroot_vim.sh
./6.72-chroot_stripping.sh
exit
exit
exit
chroot $LFS_MOUNT /tools/bin/env -i HOME=/root TERM=$TERM PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /tools/bin/bash --login
cd /root/lfs
/tools/bin/find /{,usr/}{bin,lib,sbin} -type f -exec /tools/bin/strip --strip-debug '{}' ';'
./6.73-chroot_cleaning-up.sh
