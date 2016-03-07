#!/bin/bash
echo ""
echo "### -------------------------------"
echo "###    INSTALLING BASIC SYSTEM  ###"
echo "###         CHAPTER 6.all       ###"
echo "### Installing Basic System Software"
echo "### Must be run as \"lfs\" user"
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
check_partitions
is_user lfs

./6.5-chroot_creating-directories.sh
./6.6-chroot_essentials.sh
./6.7-chroot_api-headers.sh
./6.8-chroot_man-pages.sh
./6.9-chroot_glibc.sh
./6.10-chroot_toolchain.sh
./6.11-chroot_zlib.sh
./6.12-chroot_file.sh
./6.13-chroot_binutils.sh
./6.14-chroot_gmp.sh
./6.15-chroot_mpfr.sh
./6.16-chroot_mpc.sh
./6.17-chroot_gcc.sh
./6.18-chroot_bzip2.sh
./6.19-chroot_pkg-config.sh
./6.20-chroot_ncurses.sh
./6.21-chroot_attr.sh
./6.22-chroot_acl.sh
./6.23-chroot_libcap.sh
./6.24-chroot_sed.sh
./6.25-chroot_shadow.sh
./6.26-chroot_psmisc.sh
./6.27-chroot_procps-ng.sh
./6.28-chroot_e2fsprogs.sh
./6.29-chroot_coreutils.sh
./6.30-chroot_iana-etc.sh
./6.31-chroot_m4.sh
./6.32-chroot_flex.sh
./6.33-chroot_bison.sh
./6.34-chroot_grep.sh
./6.35-chroot_readline.sh
./6.36-chroot_bash.sh
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
./6.73-chroot_cleaning-up.sh
