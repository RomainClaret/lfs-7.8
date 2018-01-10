#!/bin/bash
echo ""
echo "### --------------------------------"
echo "###  CREATE LFS TOOLS DIRECTORY  ###"
echo "###          CHAPTER 4.2         ###"
echo "### Creating the LFS/tools Directory"
echo "### Must be run as \"root\""
echo "### --------------------------------"

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
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo "... Creating the required tools directory at $LFS_MOUNT/tools"
mkdir -pv $LFS_MOUNT/tools

echo ""
echo "... Creating the symlink on the root directory to $LFS_MOUNT/tools"
ln -sv $LFS_MOUNT/tools /

echo ""
echo "######### END OF CHAPTER 4.2 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./4.3-root_adding-lfs-user.sh"
echo ""

exit 0
