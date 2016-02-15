#!/bin/bash
echo ""
echo "### --------------------------"
echo "###   MAKE NEW PARTITION   ###"
echo "###      CHAPTER 2.ALL     ###"
echo "### Run all chapter 2"
echo "### Must be run as \"root\""
echo "### --------------------------"
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
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

./2.3-root_create-files-system-on-partitions.sh
./2.4-root_set-lfs-variable.sh
./2.5-root_mount-new-partitions.sh

echo ""
echo "####### END OF CHAPTER 2.ALL #######"
