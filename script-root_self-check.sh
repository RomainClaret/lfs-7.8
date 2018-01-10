#!/bin/bash
echo ""
echo "### -------------"
echo "### CHECK OF SELF"
echo "### Must be run as \"root\""
echo "### -------------"

echo ""
echo "... Loading commun functions"
if [ ! -f ./script-all_commun-functions.sh ]
then
    echo "!! Fatal Error 1: './script-all_commun-functions.sh' not found."
    exit 1
fi
source ./script-all_commun-functions.sh

echo ""
echo "... Giving execution right to all self scripts"
self_check

echo ""
echo "######### END OF CHECK OF SELF ########"
echo ""
