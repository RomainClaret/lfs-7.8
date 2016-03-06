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
	echo "!! Info: $LFS_PARTITION_ROOT has been mounted correctly"

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

function init_tarball {
	echo "....Initializing '$INSTALL_NAME' tarball"
	if [ ! -d $LFS_MOUNT_SOURCES/$INSTALL_NAME*/  ]; then
	    tar xf $SOURCE_FILE_NAME
			echo "---> Initialized '$INSTALL_NAME' tarball"
	else
	    SHOULD_NOT_CLEAN=1
			echo "---> Tarball '$INSTALL_NAME' is already initialized."
	fi
}

function get_build_errors {
	WARNINGS_COUNTER=0
  ERRORS_COUNTER=0

	WARNINGS_COUNTER=$(grep -n " [Ww]arnings*:* " $LFS_BUILD_LOGS_5* | wc -l)
	ERRORS_COUNTER=$(grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_5* | wc -l)

	if [ $ERRORS_COUNTER -ne 0 ]; then
	    echo "!! Fatal Error 7: $SOURCE_FILE_NAME build has $ERRORS_COUNTER errors"
	    grep -n " [Ee]rrors*:* \|^FAIL:" $LFS_BUILD_LOGS_5*
	    echo "--> Please check on http://www.linuxfromscratch.org/lfs/build-logs for comparaison"
			exit 7
	else
		  echo "---> Congrats you have no errors."
	fi
}
