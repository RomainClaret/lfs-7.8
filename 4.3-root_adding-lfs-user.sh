#!/bin/bash
echo ""
echo "### ------------------------"
echo "###  ADDING THE LFS USER ###"
echo "###      CHAPTER 4.3     ###"
echo "### Adding the LFS User"
echo "### Must be run as \"root\""
echo "### ------------------------"

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
if [ $( readlink -f /bin/sh ) != "/bin/bash" ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
fi

echo ""
echo "... Creating the lfs group"
groupadd $LFS_GROUPNAME

echo ""
echo "... Creating the lfs user and add to lfs group"
useradd -s /bin/bash -g $LFS_GROUPNAME -m -k /dev/null $LFS_USERNAME

echo ""
echo "... Adding a password to the lfs user"
echo "$LFS_USERNAME:$LFS_PASSWORD" | chpasswd

echo ""
echo "... Granting to lfs user full access to $LFS_MOUNT_TOOLS and $LFS_MOUNT_SOURCES"
chown -v lfs $LFS_MOUNT_TOOLS
chown -v lfs $LFS_MOUNT_SOURCES

echo ""
echo "... Copying all the lfs setup scripts that must be executed as lfs user to the lfs user's home directory"
if [ -d $LFS_SCRIPT_HOME ]
then
  echo ".... Resetting setup scripts folder"
  rm -rf $LFS_SCRIPT_HOME
fi
mkdir $LFS_SCRIPT_HOME
cp 4.4* $LFS_SCRIPT_HOME
cp 5* $LFS_SCRIPT_HOME
cp script-* $LFS_SCRIPT_HOME
chown -R lfs:lfs $LFS_SCRIPT_HOME
chmod -R 760 $LFS_SCRIPT_HOME/

echo "... Creating a build-logs folder"
if [ -d $LFS_BUILD_LOGS ]
then
  echo ".... Resetting the build-logs folder"
  rm -rf $LFS_BUILD_LOGS
fi
mkdir $LFS_BUILD_LOGS

echo "... Creating a build-logs for Chapter 5"
echo "########################################################" > $LFS_BUILD_LOGS_MAIN_5
echo "LOG for the chapter 5: Constructing the Temporary System" >> $LFS_BUILD_LOGS_MAIN_5
echo "Runned on on $(date -u)" >> $LFS_BUILD_LOGS_MAIN_5
echo "########################################################" >> $LFS_BUILD_LOGS_MAIN_5
echo "" >> $LFS_BUILD_LOGS_MAIN_5

chown -v lfs $LFS_BUILD_LOGS
chown -v lfs $LFS_BUILD_LOGS_MAIN_5

echo ""
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "Read carefully the following instructions"
echo ""
echo -e "\a"
read -p "Enter to confirm" -n 1 -r
echo ""

echo ""
echo "######### END OF CHAPTER 4.3 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next steps:"
echo "### su - lfs"
echo "### cd setup-scripts"
echo "### ./4.4-lfs_setting-up-environment.sh"
echo ""

exit 0
