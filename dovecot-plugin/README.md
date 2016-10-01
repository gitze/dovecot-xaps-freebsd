iOS Push Email for Dovecot - FreeBSD 10
=======================================

What is this?
-------------
Compile and install instructions for the [dovecot-xaps-plugin](https://github.com/st3fan/dovecot-xaps-plugin) project used on a FreeBSD 10 system

What is iOS Push Email for Dovecot?
-----------------------------------
The dovecot-plugin [dovecot-xaps-plugin](https://github.com/st3fan/dovecot-xaps-plugin) together with the xaps daemon [dovecot-xaps-daemon](https://github.com/st3fan/dovecot-xaps-daemon) project will enable push email for iOS devices that talk to your Dovecot 2.0.x IMAP server.



Installation on FreeBSD 10
==========================

Prerequisites
-------------
Please read carefully the instructions on the [dovecot-xaps-plugin](https://github.com/st3fan/dovecot-xaps-plugin) project.

I used the installation within following environment:
* FreeBSD 10.3
* dovecot 2
* xaps daemon [dovecot-xaps-daemon](https://github.com/st3fan/dovecot-xaps-daemon)


Compile and Installation
--------------------------
```
mkdir -p /tmp/xaps-build/
cd /tmp/xaps-build/

# get additional files and patches
git clone https://github.com/gitze/dovecot-xaps-freebsd.git

# get plugin source
git clone https://github.com/st3fan/dovecot-xaps-plugin.git
cd dovecot-xaps-plugin

patch Makefile ../dovecot-xaps-freebsd/dovecot-plugin/Makefile.patch
make all
make install
make clean

# install dovecot2 plugin configuration
cp xaps.conf /usr/local/etc/dovecot/conf.d/95-xaps.conf
```
