#!/tools/bin/bash

CHAPTER_SECTION=7
INSTALL_NAME=bash-shell

echo ""
echo "### ---------------------------"
echo "###         BASH-SHELL      ###"
echo "###        CHAPTER 7.$CHAPTER_SECTION      ###"
echo "### The Bash Shell Startup Files"
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
echo "... Creating /etc/profile"
cat > /etc/profile << EOF
# Begin /etc/profile
export LANG=$LFS_LANGUAGE
# End /etc/profile
EOF

echo ""
echo "... Review content of /etc/profile "
cat /etc/profile | tee $LOG_FILE-profile.log
echo "<-- End"

echo ""
echo "######### END OF CHAPTER 7.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./7.8-chroot_etc-inputrc.sh"
echo ""

exit 0
