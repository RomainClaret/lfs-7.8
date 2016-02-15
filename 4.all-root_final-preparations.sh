#!/bin/bash
echo ""
echo "### --------------------------------"
echo "###   DO ALL FINAL PREPARATIONS  ###"
echo "###        CHAPTER 2-3-4.ALL       ###"
echo "### Run all chapter 2, 3, and 4"
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

./4.2-root_create-lfs-tools-directory.sh
./4.3-root_adding-lfs-user.sh

echo ""
echo "### END OF CHAPTER 2-3-4.ALL ###"
echo ""

return 0
