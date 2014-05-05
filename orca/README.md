Switch from Angstrom to Ubuntu
==============================

Made easy by: [ARMhf](http://www.armhf.com/)


Prepare a Bootable microSD Card:
--------------------------------

Download [win32diskimager](http://sourceforge.net/projects/win32diskimager/).

Download [Ubuntu image](http://s3.armhf.com/debian/precise/bone/ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img.xz).

Write the image to a microSD card.

Flash Ubuntu onto the eMMC
--------------------------

With the BBB's pwoer off, insert the microSD card.

Hold down the user boot button, then apply power.

Login. (default name: ubuntu, default password: ubuntu)

Put the image on the microSD card and unpack it to the eMMC:

`wget http://s3.armhf.com/debian/precise/bone/ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img.xz`

`xz -cd ubuntu-precise-12.04.3-armhf-3.8.13-bone30.img > /dev/mmcblk1`

This should provide enough time to grab a snack.

When it's done, shut down and remove the microSD card.

Configure Ubuntu on the BBB:
----------------------------

`sudo apt-get update`

`sudo apt-get upgrade`

`sudo apt-get install build-essential`

`wget http://s3.armhf.com/debian/precise/node-v0.10.21-precise-armhf.tar.xz`

`sudo tar xJvf node-v*-precise-armhf.tar.xz -C /usr/local --strip-components 1`

Now, copy over the contents of this folder and enjoy.
