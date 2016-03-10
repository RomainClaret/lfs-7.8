#!/bin/bash

echo ""
echo "### -------------------------------"
echo "###  CONFIGURATION BOOTSCRIPTS  ###"
echo "###         CHAPTER 7.all       ###"
echo "### System Configuration and Bootscripts"
echo "### Must be run as \"chroot\" user"
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
is_user root
check_chroot

./7.2-chroot_bootscripts.sh
./7.4-chroot_managing-devices.sh
./7.5-chroot_network.sh
./7.6-chroot_system-v.sh
./7.7-chroot_bash-shell.sh
./7.8-chroot_etc-inputrc.sh
./7.9-chroot_etc-shells.sh
