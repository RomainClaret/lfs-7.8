#!/bin/bash
echo ""
echo "### -------------------------------"
echo "###     CONSTRUCT TEMP SYSTEM   ###"
echo "###         CHAPTER 5.all       ###"
echo "### Constructing a Temporary System"
echo "### Must be run as \"lfs\" user"
echo "### -------------------------------"

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

./5.3-lfs_check-tools.sh

echo ""
echo "######### END OF CHAPTER 5.all ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.X-lfs_empty-skeleton.sh"
echo ""
