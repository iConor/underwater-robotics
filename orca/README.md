Switch to Ubuntu 12.04 LTS
==========================


Make Bootable microSD Card:
---------------------------

download win32diskimager - http://sourceforge.net/projects/win32diskimager/

download image - http://s3.armhf.com/debian/precise/bone/ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img.xz

put the image on a microSD card using win32diskimager

Flash New Image onto eMMC
-------------------------

power off beaglebone black, insert microSD card

hold down user boot button, apply power

default login: ubuntu

default password: ubuntu

wget http://s3.armhf.com/debian/precise/bone/ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img.xz

xz -cd ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img > /dev/mmcblk1

snack time

when it's done, shut down and remove microSD

Configure Ubuntu BBB:
---------------------

sudo apt-get update

sudo apt-get upgrade

sudo apt-get install build-essential

wget http://s3.armhf.com/debian/precise/node-v0.10.21-precise-armhf.tar.xz

tar xJvf node-v*-precise-armhf.tar.xz -C /usr/local --strip-components 1
