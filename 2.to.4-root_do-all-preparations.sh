#!/bin/bash
echo ""
echo "### --------------------------"
echo "###   DO ALL PREPARATIONS  ###"
echo "###    CHAPTER 2-3-4.ALL   ###"
echo "### Run all chapter 2, 3 and 4"
echo "### Must be run as \"root\""
echo "### --------------------------"

./2.all-root_make-new-partitions.sh
./3.all-root_packages-patches.sh
./4.all-root_final-preparations.sh

echo ""
echo "### END OF CHAPTER 2-3-4.ALL ###"
