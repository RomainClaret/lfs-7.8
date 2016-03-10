#!/bin/bash

CHAPTER_SECTION=5
INSTALL_NAME=netconfig

echo ""
echo "### ---------------------------"
echo "###         SKELETON      ###"
echo "###        CHAPTER 7.$CHAPTER_SECTION      ###"
echo "### skeleton"
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
echo "... Creating /etc/sysconfig/ifconfig.eth0"
cd /etc/sysconfig/
cat > ifconfig.eth0 << EOF
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=$LFS_ADDRESS
GATEWAY=$LFS_GATEWAY
PREFIX=$LFS_PREFIX
BROADCAST=$LFS_BROADCAST
EOF

echo ""
echo "... Creating /etc/sysconfig/ifconfig.eth0"
cat > /etc/resolv.conf << EOF
# Begin /etc/resolv.conf
# domain <Your Domain Name>
nameserver $LFS_NS1
nameserver $LFS_NS2
# End /etc/resolv.conf
EOF

echo "... Creating /etc/hostname"
echo "$LFS_IP_HOSTNAME" > /etc/hostname

echo "... Creating /etc/hosts File"
cat > /etc/hosts << EOF
# Begin /etc/hosts (network card version)
127.0.0.1 localhost
$LFS_ADDRESS $LFS_DOMAINNAME $LFS_HOSTNAME
# End /etc/hosts (network card version)
EOF

echo ""
echo "... Review content of /etc/sysconfig/ifconfig.eth0"
cat /etc/sysconfig/ifconfig.eth0 | tee $LOG_FILE-ifconfig-eth0.log
echo "<-- End"

echo ""
echo "... Review content of /etc/resolv.conf"
cat /etc/resolv.conf | tee $LOG_FILE-resolv.log
echo "<-- End"


echo ""
echo "... Review content of /etc/hostname"
cat /etc/hostname | tee $LOG_FILE-hostname.log
echo "<-- End"


echo ""
echo "... Review content of /etc/hosts"
cat /etc/hosts | tee $LOG_FILE-hosts.log
echo "<-- End"

echo ""
echo "######### END OF CHAPTER 7.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./7.6-chroot_system-v.sh"
echo ""

exit 0
