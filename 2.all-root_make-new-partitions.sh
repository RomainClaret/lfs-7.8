#!/bin/bash
echo ""
echo "### --------------------------"
echo "###   MAKE NEW PARTITION   ###"
echo "###      CHAPTER 2.ALL     ###"
echo "### Run all chapter 2"
echo "### Must be run as \"root\""
echo "### --------------------------"

./0.0-root_initial.sh
./2.3-root_create-files-system-on-partitions.sh
./2.4-root_set-lfs-variable.sh
./2.5-root_mount-new-partitions.sh
./2.all-root_make-new-partitions.sh
./3.all-root_packages-patches.sh
./2.to.4-root_do-all-preparations.sh

echo ""
echo "####### END OF CHAPTER 2.ALL #######"
