#!/bin/bash

CHAPTER_SECTION=9
INSTALL_NAME=etc-shells

echo ""
echo "### ---------------------------"
echo "###         ETC-SHELLS      ###"
echo "###        CHAPTER 7.$CHAPTER_SECTION      ###"
echo "### Create the /etc/shells File"
echo "### Must be run as \"chroot\" user"
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
is_user root
check_chroot

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_7$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Creating /etc/shells"
cat > /etc/shells << "EOF"
# Begin /etc/shells
/bin/sh
/bin/bash
# End /etc/shells
EOF

echo ""
echo "... Review content of /etc/shells"
cat /etc/shells | tee $LOG_FILE-shells.log
echo "<-- End"

echo ""
echo "######### END OF CHAPTER 7.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./8.all-chroot_make-bootable.sh"
echo ""

exit 0
