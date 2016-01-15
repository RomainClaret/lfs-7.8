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
  chmod +x 2.3-root_create-files-system-on-partition.sh
  chmod +x 2.4-root_set-lfs-variable.sh
	chmod +x 2.5-root_mount-new-partition.sh
	chmod +x 2.all-root_make-new-partition.sh
	chmod +x 2.to.4-root_do-all-preparations.sh
}

function check_partitions
{
	echo ""
	blkid "$LFS_PARTITION_ROOT" | grep ext4
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 4: $LFS_PARTITION_ROOT not mounted, run 2.all-root_make-new-partition.sh"
	  exit 4
	fi
	echo "!! Info: $LFS_PARTITION_ROOT has been mounted correctly"

	echo ""
	swapon -s | grep "$LFS_PARTITION_SWAP"
	if [ ! $? -eq 0 ]
	then
	  echo "!! Fatal Error 5: $LFS_PARTITION_SWAP has not the swap activated, run 2.all-root_make-new-partition.sh"
	fi
	echo "!! Info: $LFS_PARTITION_SWAP is correctly configured as swap"
}
