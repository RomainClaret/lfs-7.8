#!/bin/bash
echo ""
echo "### -------------"
echo "### CHECK OF SELF"
echo "### Must be run as \"root\""
echo "### -------------"
echo ""

echo "... Giving execution right to all self scripts"
chmod +x 0.0-root_initial.sh
chmod +x 2.3-root_create-files-system-on-partition.sh
chmod +x 2.4-root_set-lfs-variable.sh
