#!/bin/bash

echo ""
echo "### -------------------------------"
echo "###    INSTALLING BASIC SYSTEM  ###"
echo "###         CHAPTER 6.all       ###"
echo "### Installing Basic System Software"
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
is_user root

./6.2-root_preparing-virtual-kernel.sh
./6.4-root_chroot-environment.sh
