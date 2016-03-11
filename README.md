# Linux from Scratch 7.8
[![Build Status](https://travis-ci.org/Rocla/lfs-7.8.svg?branch=master)](https://travis-ci.org/Rocla/lfs-7.8)

This Shell scripts have for purpose to let you to speed up the process to build a LFS system.

The steps are based on the instruction of Linux From Scratch implementation 7.8.

## What does it do?
Running all the steps until the reboot of 9.3 will give a running LFS on your host machine (you can choose it from the GRUB at boot) :)

## License

Automated LFS 7.8 by [Romain Claret](http://www.romainclaret.com) is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

## Instructions
The raport can be found in french at the root of this repo: Instructions_FR.pdf.
There will be an english version Markdown soon... soon... (I don't know when to be honest, but one day!)

However, note that all the instructions in the scripts themselves are in english. So... If it's alright with you... I don't think you need my report to be translated right away..

## I used virtualbox:
https://www.virtualbox.org

## Debian running on my host machine:
- Host machine installer: http://ftp.it.debian.org/debian-cd/7.8.0/i386/bt-cd/debian-7.8.0-i386-xfce-CD-1.iso.torrent
- Core: 1
- Ram: 12GB
- Host HDD: 40GB
- LFS HDD: 20BG (recommended 10GB by LFS 7.8)

## How to start?
- Clone the repo on your freshly installed debian
- Go to the folder (default: lfs-7.8)
- Give the permission rights to the first file (chmod +x 0.0-root_initial.sh)
- Run the first file (./0.0-root_initial.sh)
- Then you have the options to go
  - auto-pilote
    - ./all-root_auto-pilote.sh
  - semi-auto-pilote
    - ./2.all-root_make-new-partitions.sh
    - ./3.all-root_packages-patches.sh
    - ./4.all-root_final-preparations.sh
    - ./5.all-lfs_construct-tools.sh
    - ./6.all-part-1-root_installing-basic-system.sh
    - ./6.all-part-2-chroot_installing-basic-system.sh
    - ./7.all-chroot_configuration_bootscripts.sh
    - ./8.all-chroot_make-bootable.sh
  - sequential (script per script)
    - start with: ./2.3-root_create-files-system-on-partitions.sh

## Tips:
- Do snapshots often!

## I love pull requests :)

C ya :)
