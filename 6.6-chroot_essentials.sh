#!/tools/bin/bash

CHAPTER_SECTION=6
INSTALL_NAME=create-files

echo ""
echo "### ---------------------------"
echo "###         ESSENTIALS      ###"
echo "###        CHAPTER 6.$CHAPTER_SECTION      ###"
echo "### Creating Essential Files and Symlinks"
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
check_partitions
check_chroot

echo ""
echo "... Setup building environment"
LOG_FILE=$LFS_BUILD_LOGS_6$CHAPTER_SECTION-$INSTALL_NAME

echo ""
echo "... Linking essentials"
ln -sv /tools/bin/{bash,cat,echo,pwd,stty} /bin &>> $LOG_FILE
ln -sv /tools/bin/perl /usr/bin &>> $LOG_FILE
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib &>> $LOG_FILE
ln -sv /tools/lib/libstdc++.so{,.6} /usr/lib &>> $LOG_FILE
sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
ln -sv bash /bin/sh &>> $LOG_FILE
ln -sv /proc/self/mounts /etc/mtab &>> $LOG_FILE

echo "... Creating etc/passwd"
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

echo "... Creating /etc/group"
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
nogroup:x:99:
users:x:999:
EOF

echo ""
echo "######### END OF CHAPTER 6.$CHAPTER_SECTION ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./6.7-chroot_api-headers.sh"
echo ""

exit 0
