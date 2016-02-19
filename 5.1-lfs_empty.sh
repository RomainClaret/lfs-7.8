#!/bin/bash
echo ""
echo "### ---------------------------"
echo "###    EMPTY   ###"
echo "###        CHAPTER 5.?      ###"
echo "### ???"
echo "### Must be run as \"lfs\" user"
echo "### ---------------------------"

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
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo "... EMPTY"

echo ""
echo "######### END OF CHAPTER 5.? ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### NOT IMPLEMENTED YET ./5.....sh"
echo ""

exit 0
