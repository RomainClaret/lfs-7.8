#!/bin/bash

CHAPTER_SECTION=0

echo ""
echo "### ---------------------------"
echo "###       RESTORE TOOLS     ###"
echo "###        CHAPTER 5.$CHAPTER_SECTION      ###"
echo "### This is used to restore tools if the chapter 5 already has been installed once"
echo "### Must be run as \"root\" user"
echo "### ---------------------------"

echo ""
echo "... Checking basic tools"
./5.3-lfs_check-tools.sh

rm -rf $LFS_MOUNT_TOOLS
cp -r $LFS_ROOT_BACKUP_FOLDER $LFS_MOUNT_TOOLS
chmod -R 755 $LFS_MOUNT_TOOLS

echo ""
echo "######### END OF CHAPTER 5.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.2-root_preparing-virtual-kernel.sh"
echo ""

exit 0
