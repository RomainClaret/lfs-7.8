# 2.3 Creating a File System on the Partition
LFS_HDD=/dev/sdb
LFS_PARTITION_SWAP=/dev/sdb1
LFS_PARTITION_ROOT=/dev/sdb2

# 2.4
LFS_MOUNT=/mnt/lfs

# 3.all
LFS_ROOT_BACKUP_FOLDER=~/lfs-backup/tools
LFS_ROOT_BACKUP_LOGS=~/lfs-backup-logs
LFS_BACKUPS=~/lfs-backup/sources/
LFS_OFFICIAL_78_PACKAGES_NUMBER=82 # including wget-list and md5sums files
LFS_OFFICIAL_78_PACKAGES_LIST="http://www.linuxfromscratch.org/lfs/view/7.8/wget-list"
LFS_OFFICIAL_78_PACKAGES_MD5="http://www.linuxfromscratch.org/lfs/view/7.8/md5sums"

# 4.3
LFS_USERNAME=lfs
LFS_GROUPNAME=lfs
LFS_PASSWORD=lfs
LFS_SCRIPT_HOME=/home/lfs/setup-scripts
LFS_BUILD_LOGS=$LFS_MOUNT/build-logs
LFS_BUILD_LOGS_MAIN_5=$LFS_BUILD_LOGS/chapter_5_0.log
LFS_BUILD_LOGS_5=$LFS_BUILD_LOGS/chapter_5_
LFS_MOUNT_TOOLS=$LFS_MOUNT/tools
LFS_MOUNT_SOURCES=$LFS_MOUNT/sources

# 5.4 and more
PROCESSOR_CORES=-j1

# 6.2 and more
LFS_BUILD_LOGS_6_HOST=$LFS_BUILD_LOGS/chapter_6_
LFS_BUILD_LOGS_TARGET=/build-logs
LFS_BUILD_LOGS_6=$LFS_BUILD_LOGS_TARGET/chapter_6_

# 6.9
LFS_TIME_ZONE=Europe/Zurich

# 7.2 and more
LFS_BUILD_LOGS_7=$LFS_BUILD_LOGS_TARGET/chapter_7_

# 7.5 and more
LFS_ADDRESS=192.168.1.2
LFS_GATEWAY=192.168.1.1
LFS_PREFIX=24
LFS_BROADCAST=192.168.1.255
LFS_NS1=8.8.8.8
LFS_NS2=8.8.4.4
LFS_HOSTNAME=lfs
LFS_DOMAINNAME=lfs.rocla.ch

# 7.7
LFS_LANGUAGE=en_US.UTF-8

# 8.2 and more
LFS_BUILD_LOGS_8=$LFS_BUILD_LOGS_TARGET/chapter_8_

# 9.1 and more
LFS_BUILD_LOGS_9=$LFS_BUILD_LOGS_TARGET/chapter_9_
LFS_DISTRIBUTION_ID="Linux From Scratch"
LFS_DISTRIBUTION_RELEASE="7.8"
LFS_DISTRIBUTION_CODENAME="Linux From Scratch"
LFS_DISTRIBUTION_DESCRIPTION="Linux From Scratch by Rocla using automated scripts from github.com/Rocla/lfs-7.8"
