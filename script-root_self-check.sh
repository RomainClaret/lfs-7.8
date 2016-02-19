#!/bin/bash
echo ""
echo "### -------------"
echo "### CHECK OF SELF"
echo "### Must be run as \"root\""
echo "### -------------"

echo ""
echo "... Giving execution right to all self scripts"
chmod +x 0.0-root_initial.sh
chmod +x 2.3-root_create-files-system-on-partitions.sh
chmod +x 2.4-root_set-lfs-variable.sh
chmod +x 2.5-root_mount-new-partitions.sh
chmod +x 2.all-root_make-new-partitions.sh
chmod +x 2.to.4-root_do-all-preparations.sh
chmod +x 3.all-root_packages-patches.sh
chmod +x 4.2-root_create-lfs-tools-directory.sh
chmod +x 4.3-root_adding-lfs-user.sh
chmod +x 4.4-lfs_setting-up-environment.sh
chmod +x 4.all-root_final-preparations.sh

echo ""
echo "######### END OF CHECK OF SELF ########"
echo ""
