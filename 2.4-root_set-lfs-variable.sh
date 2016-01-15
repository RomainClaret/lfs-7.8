#!/bin/bash
echo ""
echo "### -------------------------"
echo "###  SET THE LFS VARIABLE ###"
echo "###      CHAPTER 2.4      ###"
echo "### Setting The $LFS Variable"
echo "### Must be run as \"root\""
echo "### -------------------------"

echo ""
echo "... Loading commun functions and variables"
if [ ! -f ./script-root_commun-functions.sh ]
then
  echo "!! Fatal Error 1: './script-root_commun-functions.sh' not found."
  exit 1
fi
source ./script-root_commun-functions.sh

if [ ! -f ./script-root_commun-variables.sh ]
then
  echo "!! Fatal Error 1: './script-root_commun-variables.sh' not found."
  exit 1
fi
source ./script-root_commun-variables.sh

echo ""
echo "... Validating the environment"
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo  "... Exporting the LFS Variable"
export LFS=$LFS_MOUNT_DIR

echo ""
echo "######### END OF CHAPTER 2.4 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./2.5-root_mount-new-partition.sh"
echo ""

exit 0
