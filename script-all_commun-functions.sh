function is_user
{
	if [ $(whoami) != "$1" ]
	then
  	echo "!! Fatal Error 2: Must be run as $1"
  	exit 2
  fi
}

function self_check
{
	chmod +x 0.0-root_initial.sh
	chmod +x 2.all-root_make-new-partitions.sh
	chmod +x 2.3-root_create-files-system-on-partitions.sh
	chmod +x 2.4-root_set-lfs-variable.sh
	chmod +x 2.5-root_mount-new-partitions.sh
	chmod +x 2.to.4-root_do-all-preparations.sh
	chmod +x 3.all-root_packages-patches.sh
	chmod +x 4.all-root_final-preparations.sh
	chmod +x 4.2-root_create-lfs-tools-directory.sh
	chmod +x 4.3-root_adding-lfs-user.sh
	chmod +x 4.4-lfs_setting-up-environment.sh
	chmod +x 5.all-lfs_construct-tools.sh
	chmod +x 5.3-lfs_check-tools.sh
	chmod +x 5.4-lfs_binutils-2.25.1-pass-1.sh
	chmod +x 5.5-lfs_gcc-5.2.0-pass-1.sh
	chmod +x 5.6-lfs_linux-4.2-api-headers.sh
	chmod +x 5.7-lfs_glibc-2.22.sh
	chmod +x 5.8-lfs_libstdcpp-5.2.0.sh
	chmod +x 5.9-lfs_binutils-2.25.1-pass-2.sh
	chmod +x 5.10-lfs_gcc-5.2.0-pass-2.sh
	chmod +x 5.11-lfs_tcl-core-8.6.4.sh
	chmod +x 5.12-lfs_expect-5.45.sh
	chmod +x 5.13-lfs_dejagnu-1.5.3.sh
	chmod +x 5.14-lfs_check-0.10.0.sh
	chmod +x 5.15-lfs_ncurses-6.0.sh
	chmod +x 5.16-lfs_bash-4.3.30.sh
	chmod +x 5.17-lfs_bzip2-1.0.6.sh
	chmod +x 5.18-lfs_coreutils-8.24.sh
	chmod +x 5.19-lfs_diffutils-3.3.sh
	chmod +x 5.20-lfs_file-5.24.sh
	chmod +x 5.21-lfs_findutils-4.4.2.sh
	chmod +x 5.22-lfs_gawk-4.1.3.sh
	chmod +x 5.23-lfs_gettext-0.19.5.1.sh
	chmod +x 5.24-lfs_grep-2.21.sh
	chmod +x 5.25-lfs_gzip-1.6.sh
	chmod +x 5.26-lfs_m4-1.4.17.sh
	chmod +x 5.27-lfs_make-4.1.sh
	chmod +x 5.28-lfs_patch-2.7.5.sh
	chmod +x 5.29-lfs_perl-5.22.0.sh
	chmod +x 5.30-lfs_sed-4.2.2.sh
	chmod +x 5.31-lfs_tar-1.28.sh
	chmod +x 5.32-lfs_texinfo-6.0.sh
	chmod +x 5.33-lfs_util-linux-2.27.sh
	chmod +x 5.34-lfs_xz-5.2.1.sh
	chmod +x 5.35-lfs_stripping.sh
	chmod +x 5.36-root_changing-ownership.sh
	chmod +x 6.all-part-1-root_installing-basic-system.sh
	chmod +x 6.all-part-2-chroot_installing-basic-system.sh
	chmod +x 6.2-root_preparing-virtual-kernel.sh
	chmod +x 6.4-root_chroot-environment.sh
	chmod +x 6.5-chroot_creating-directories.sh
	chmod +x 6.6-chroot_essentials.sh
	chmod +x 6.7-chroot_api-headers.sh
	chmod +x 6.8-chroot_man-pages.sh
	chmod +x 6.9-chroot_glibc.sh
	chmod +x 6.10-chroot_toolchain.sh
	chmod +x 6.11-chroot_zlib.sh
	chmod +x 6.12-chroot_file.sh
	chmod +x 6.13-chroot_binutils.sh
	chmod +x 6.14-chroot_gmp.sh
	chmod +x 6.15-chroot_mpfr.sh
	chmod +x 6.16-chroot_mpc.sh
	chmod +x 6.17-chroot_gcc.sh
	chmod +x 6.18-chroot_bzip2.sh
	chmod +x 6.19-chroot_pkg-config.sh
	chmod +x 6.20-chroot_ncurses.sh
	chmod +x 6.21-chroot_attr.sh
	chmod +x 6.22-chroot_acl.sh
	chmod +x 6.23-chroot_libcap.sh
	chmod +x 6.24-chroot_sed.sh
	chmod +x 6.25-chroot_shadow.sh
	chmod +x 6.26-chroot_psmisc.sh
	chmod +x 6.27-chroot_procps-ng.sh
	chmod +x 6.28-chroot_e2fsprogs.sh
	chmod +x 6.29-chroot_coreutils.sh
	chmod +x 6.30-chroot_iana-etc.sh
	chmod +x 6.31-chroot_m4.sh
	chmod +x 6.32-chroot_flex.sh
	chmod +x 6.33-chroot_bison.sh
	chmod +x 6.34-chroot_grep.sh
	chmod +x 6.35-chroot_readline.sh
	chmod +x 6.36-chroot_bash.sh
	chmod +x 6.37-chroot_bc.sh
	chmod +x 6.38-chroot_libtool.sh
	chmod +x 6.39-chroot_gdbm.sh
	chmod +x 6.40-chroot_expat.sh
	chmod +x 6.41-chroot_inetutils.sh
	chmod +x 6.42-chroot_perl.sh
	chmod +x 6.43-chroot_xml-parser.sh
	chmod +x 6.44-chroot_autoconf.sh
	chmod +x 6.45-chroot_automake.sh
	chmod +x 6.46-chroot_diffutils.sh
	chmod +x 6.47-chroot_gawk.sh
	chmod +x 6.48-chroot_findutils.sh
	chmod +x 6.49-chroot_gettext.sh
	chmod +x 6.50-chroot_intltool.sh
	chmod +x 6.51-chroot_gperf.sh
	chmod +x 6.52-chroot_groff.sh
	chmod +x 6.53-chroot_xz.sh
	chmod +x 6.54-chroot_grub.sh
	chmod +x 6.55-chroot_less.sh
	chmod +x 6.56-chroot_gzip.sh
	chmod +x 6.57-chroot_iproute2.sh
	chmod +x 6.58-chroot_kbd.sh
	chmod +x 6.59-chroot_kmod.sh
	chmod +x 6.60-chroot_libpipeline.sh
	chmod +x 6.61-chroot_make.sh
	chmod +x 6.62-chroot_patch.sh
	chmod +x 6.63-chroot_sysklogd.sh
	chmod +x 6.64-chroot_sysvinit.sh
	chmod +x 6.65-chroot_tar.sh
	chmod +x 6.66-chroot_texinfo.sh
	chmod +x 6.67-chroot_eudev.sh
	chmod +x 6.68-chroot_util-linux.sh
	chmod +x 6.69-chroot_man-db.sh
	chmod +x 6.70-chroot_vim.sh
	chmod +x 6.72-chroot_stripping.sh
	chmod +x 6.73-chroot_cleaning-up.sh
	chmod +x 7.all-chroot_configuration_bootscripts.sh
	chmod +x 7.2-chroot_bootscripts.sh
	chmod +x 7.4-chroot_managing-devices.sh
	chmod +x 7.5-chroot_network.sh
	chmod +x 7.6-chroot_system-v.sh
	chmod +x 7.7-chroot_bash-shell.sh
	chmod +x 7.8-chroot_etc-inputrc.sh
	chmod +x 7.9-chroot_etc-shells.sh
	chmod +x 8.all-chroot_make-bootable.sh
	chmod +x 8.2-chroot_etc-fstab.sh
	chmod +x 8.3-chroot_linux-42.sh
	chmod +x 8.4-chroot_grub.sh
}

function check_partitions
{
	echo ""
	/sbin/blkid "$LFS_PARTITION_ROOT" | grep ext4
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 4: $LFS_PARTITION_ROOT not mounted, run ./2.all-root_make-new-partitions.sh"
	  exit 4
	fi
	echo "!! Info: $LFS_PARTITION_ROOT is correctly mounted"

	echo ""
	/sbin/swapon -s | grep "$LFS_PARTITION_SWAP"
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 5: $LFS_PARTITION_SWAP has not the swap activated, run ./2.all-root_make-new-partitions.sh"
		exit 5
	fi
	echo "!! Info: $LFS_PARTITION_SWAP is correctly configured as swap"
}

function check_tools
{
	echo "... Checking symlinked tools for compilation"
	if [ $( readlink -f /bin/sh ) != "/bin/bash"   ]
	then
	  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
	  exit 3
	fi

	if [ $( readlink -f /usr/bin/awk ) != "/usr/bin/gawk"   ]
	then
	  echo "!! Fatal Error 3: /usr/bin/awk is not symlinked to /usr/bin/gawk"
	  exit 3
	fi

	if [ ! -f /usr/bin/gawk ]
	then
	  echo "!! Fatal Error 1: '/usr/bin/gawk' not found."
	  exit 1
	fi

	if [ $( readlink -f /usr/bin/yacc ) != "/usr/bin/bison.yacc"   ]
	then
	  echo "!! Fatal Error 3: /usr/bin/yacc is not symlinked to /usr/bin/bison.yacc"
	  exit 3
	fi

	if [ ! -f /usr/bin/bison.yacc ]
	then
	  echo "!! Fatal Error 1: '/usr/bin/bison.yacc' not found."
	  exit 1
	fi
	echo "---> All symlinks are correct"
}

function check_tarball_uniqueness
{
	echo "... Checking uniqueness of tarball"
	SOURCE_FILE_NAME=$(ls | egrep "^$INSTALL_NAME.+tar")
	SOURCE_FILE_COUNTER=$(ls | egrep "^$INSTALL_NAME.+tar" | wc -l)
	if [ $SOURCE_FILE_COUNTER -eq 0 ]; then
		echo "!! Fatal Error 6: '$INSTALL_NAME' tarballs is not found."
		exit 5
	elif [ $SOURCE_FILE_COUNTER -gt 1 ]; then
		echo "!! Fatal Error 6: '$INSTALL_NAME' tarballs is found but multiple times: ($SOURCE_FILE_COUNTER). It should be unique."
		exit 5
	fi
}

function init_tarball
{
	echo "....Initializing '$INSTALL_NAME' tarball"
	if [ ! -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/  ]; then
	    tar xf $SOURCE_FILE_NAME
			echo "---> Initialized '$INSTALL_NAME' tarball"
	else
	    SHOULD_NOT_CLEAN=1
			echo "---> Tarball '$INSTALL_NAME' is already initialized."
	fi
}

function extract_tarball
{
	echo "....Loading '$INSTALL_NAME' tarball"
	if [ ! -d /sources/$INSTALL_NAME*/  ]; then
	    tar xf $SOURCE_FILE_NAME
			echo "---> Loaded '$INSTALL_NAME' tarball"
	else
	    SHOULD_NOT_CLEAN=1
			echo "---> Tarball '$INSTALL_NAME' is already initialized."
	fi
}

function get_build_errors_5
{
	WARNINGS_COUNTER=0
  ERRORS_COUNTER=0

	WARNINGS_COUNTER=$(grep -n " [Ww]arnings*:* " $LFS_BUILD_LOGS_5* | wc -l)
	ERRORS_COUNTER=$(grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_5* | wc -l)

	if [ $ERRORS_COUNTER -ne 0 ]; then
		echo "!! Info: Known errors and not critical:"
		echo "Chapters 5.5, 5.7, 5.12, 5.14, 5.15, 5.16, 5.30"
		echo ""
		echo "!! Info: Until now you had $ERRORS_COUNTER errors, however they are not all critical. Crtical errors are displayed below:"
    grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_5* | grep -v "_5_5\|_5_7\|_5_12\|_5_14\|_5_15\|_5_16\|_6_30"
    echo "--> If any error, please check on http://www.linuxfromscratch.org/lfs/build-logs for comparaison."
	else
	  echo "---> Congrats you have no errors."
	fi
}

function get_build_errors_mnt_lfs
{
	WARNINGS_COUNTER=0
  ERRORS_COUNTER=0

	WARNINGS_COUNTER=$(grep -n " [Ww]arnings*:* " $LFS_BUILD_LOGS_MNT* | wc -l)
	ERRORS_COUNTER=$(grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_MNT* | wc -l)

	if [ $ERRORS_COUNTER -ne 0 ]; then
		echo "!! Info: Until now you had $ERRORS_COUNTER errors, however they are not all critical. Crtical errors are displayed below:"
    grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_MNT* | grep -v ""
    echo "--> If any error, please check on http://www.linuxfromscratch.org/lfs/build-logs for comparaison."
	else
	  echo "---> Congrats you have no errors."
	fi
}

function get_build_errors_6
{
	WARNINGS_COUNTER=0
  ERRORS_COUNTER=0

	WARNINGS_COUNTER=$(grep -n " [Ww]arnings*:* " $LFS_BUILD_LOGS_6* | wc -l)
	ERRORS_COUNTER=$(grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_6* | wc -l)

	if [ $ERRORS_COUNTER -ne 0 ]; then
		echo "!! Info: Known errors and not critical:"
		echo "Chapters 6.9, 6.17, 6.28, 6.31, 6.33, 6.34, 6.36, 6.38, 6.40, 6.44, 6.45, 6.46, 5.57"
		echo ""
		echo "!! Info: Until now you had $ERRORS_COUNTER errors, however they are not all critical. Crtical errors are displayed below:"
    grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_6* | grep -v "_6_9\|_6_17\|_6_28\|_6_31\|_6_33\|_6_34\|_6_36\|_6_38\|_6_40\|_6_44\|_6_45\|_6_46\|_6_57"
    echo "--> If any error, please check on http://www.linuxfromscratch.org/lfs/build-logs for comparaison."
	else
	  echo "---> Congrats you have no errors."
	fi
}

function get_build_errors_7
{
	WARNINGS_COUNTER=0
  ERRORS_COUNTER=0

	WARNINGS_COUNTER=$(grep -n " [Ww]arnings*:* " $LFS_BUILD_LOGS_7* | wc -l)
	ERRORS_COUNTER=$(grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_7* | wc -l)

	if [ $ERRORS_COUNTER -ne 0 ];
	then
		echo "!! Info: Known errors and not critical:"
		echo "Chapters 7.X"
		echo ""
		echo "!! Info: Until now you had $ERRORS_COUNTER errors, however they are not all critical. Crtical errors are displayed below:"
		grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_7* | grep -v ""
		echo "--> If any error, please check on http://www.linuxfromscratch.org/lfs/build-logs for comparaison."
	else
	  echo "---> Congrats you have no errors."
	fi
}

function check_chroot
{
	if [ ! $(awk -v needle="$LFS_PARTITION_ROOT" '$1==needle {print $2}' /proc/mounts) = "/" ] ; then
		echo "!! Fatal Error 10: $LFS_PARTITION_ROOT is not mounted correctly"
		echo "### You must exit chroot and mount it with ./2.all-root_make-new-partitions.sh"
		exit 10
	else
		echo "!! Info: $LFS_PARTITION_ROOT is correctly mounted"
	fi

	if [ -z $(awk -v needle="$LFS_PARTITION_SWAP" '$1==needle {print $1}' /proc/swaps)  ] ; then
	    echo "!! Fatal Error 10: $LFS_PARTITION_SWAP has not the swap activated"
	    echo "### You must exit chroot and mount it with ./2.all-root_make-new-partitions.sh"
	 	  exit 10
	else
      echo "!! Info: $LFS_PARTITION_SWAP is correctly configured as swap"
	fi

	if test !  -d "/sources" && test ! -d "/build-logs"  ; then
	  echo "!! Fatal Error 10: $LFS_PARTITION_ROOT is not chrooted as a root directory"
  	exit 10
	fi
}
