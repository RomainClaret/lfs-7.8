#!/bin/bash
echo ""
echo "### --------------------------"
echo "###      AUTO-PILOTE       ###"
echo "###    RUN ALL CHAPTERS    ###"
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

./2.all-root_make-new-partitions.sh
./3.all-root_packages-patches.sh
./4.all-root_final-preparations.sh
./5.all-lfs_construct-tools.sh
./6.all-part-1-root_installing-basic-system.sh
./7.all-chroot_configuration_bootscripts.sh
./8.all-chroot_make-bootable.sh

echo ""
echo "####### END OF CHAPTER 2.ALL #######"
