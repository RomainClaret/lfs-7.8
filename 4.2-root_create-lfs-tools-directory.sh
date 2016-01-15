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
check_partitions
is_user root
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi
