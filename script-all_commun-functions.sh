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
	chmod +x 5.all-lfs_construct-temp-system.sh
	chmod +x 5.3-lfs_check-tools.sh
}

function check_partitions
{
	echo ""
	/sbin/blkid "$LFS_PARTITION_ROOT" | grep ext4
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 4: $LFS_PARTITION_ROOT not mounted, run 2.all-root_make-new-partition.sh"
	  exit 4
	fi
	echo "!! Info: $LFS_PARTITION_ROOT has been mounted correctly"

	echo ""
	/sbin/swapon -s | grep "$LFS_PARTITION_SWAP"
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 5: $LFS_PARTITION_SWAP has not the swap activated, run 2.all-root_make-new-partition.sh"
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

	if [ -f /usr/bin/gawk ]
	then
	  echo "!! Fatal Error 1: '/usr/bin/gawk' not found."
	  exit 1
	fi

	if [ $( readlink -f /usr/bin/yacc ) != "/usr/bin/bison.yacc"   ]
	then
	  echo "!! Fatal Error 3: /usr/bin/yacc is not symlinked to /usr/bin/bison.yacc"
	  exit 3
	fi

	if [ -f /usr/bin/bison.yacc ]
	then
	  echo "!! Fatal Error 1: '/usr/bin/bison.yacc' not found."
	  exit 1
	fi
	echo "-> All symlinks are correct"
}
