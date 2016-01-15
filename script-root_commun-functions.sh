function is_user
{
	if [ $(whoami) != "$1" ]; then
  	echo "!! Fatal Error 2: Must be run as $1";
  	exit 2;
  fi
}

function self_check
{
  chmod +x 2.3-root_create-files-system-on-partition.sh
  chmod +x 2.4-root_set-lfs-variable.sh
}
