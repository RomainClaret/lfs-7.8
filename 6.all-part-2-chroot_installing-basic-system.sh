#!/tools/bin/bash

echo ""
echo "### -------------------------------"
echo "###    INSTALLING BASIC SYSTEM  ###"
echo "###         CHAPTER 6.all       ###"
echo "### Installing Basic System Software"
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
check_chroot

echo ""
echo "... Configuring new environment"

./6.5-chroot_creating-directories.sh
rm -rf /root/lfs
mv /tools/lfs /root/lfs
cd /root/lfs
./6.6-chroot_essentials.sh
