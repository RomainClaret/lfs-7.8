# 2.3 Creating a File System on the Partition
LFS_HDD=/dev/sdb
LFS_PARTITION_SWAP=/dev/sdb1
LFS_PARTITION_ROOT=/dev/sdb2

# 2.4
LFS_MOUNT=/mnt/lfs

# 3.all
LFS_ROOT_BACKUP_FOLDER=/root/lfs-backup/tools
LFS_ROOT_BACKUP_LOGS=/root/lfs-backup-logs
LFS_BACKUPS=/root/lfs-backup/sources/
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
PROCESSOR_CORES=-j4

# 6.2 and more
LFS_BUILD_LOGS_6=$LFS_BUILD_LOGS/chapter_6_
