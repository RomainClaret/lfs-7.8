#!/bin/bash

CHAPTER_SECTION=3
INSTALL_NAME=linux

echo ""
echo "### ---------------------------"
echo "###      LINUX-42-PART-2    ###"
echo "###        CHAPTER 8.$CHAPTER_SECTION      ###"
echo "### Linux-4.20"
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
LOG_FILE=$LFS_BUILD_LOGS_8$CHAPTER_SECTION-$INSTALL_NAME
cd $(ls -d /sources/$INSTALL_NAME*/)

echo ""
echo "... Making"
make $PROCESSOR_CORES &> $LOG_FILE-make.log

echo ""
echo "... Installing Modules"
make modules_install $PROCESSOR_CORES &> $LOG_FILE-make-modules_install.log

echo ""
echo "... Post-Installing"
cp -v arch/x86/boot/bzImage /boot/vmlinuz-4.2-lfs-7.8
cp -v System.map /boot/System.map-4.2
cp -v .config /boot/config-4.2
install -d /usr/share/doc/linux-4.2
cp -r Documentation/* /usr/share/doc/linux-4.2

echo "... Configuring Linux Module Load Order"
install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF

echo ""
echo "######### END OF CHAPTER 8.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "!! Info: At this point it's safe to delete /sources if you wish"
echo "### Please run the next steps:"
echo "### pushd /sources/linux*"
echo "### make defconfig"
echo "### make menuconfig"
echo "### ./8.4-chroot_grub.sh"
echo ""




exit 0
