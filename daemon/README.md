iOS Push Email for Dovecot - FreeBSD 10
=======================================

What is this?
-------------
Compile and install instructions for the [dovecot-xaps-daemon](https://github.com/st3fan/dovecot-xaps-daemon) project used on a FreeBSD 10 system

What is iOS Push Email for Dovecot?
-----------------------------------
The dovecot-plugin [dovecot-xaps-plugin](https://github.com/st3fan/dovecot-xaps-plugin) together with the xaps daemon [dovecot-xaps-daemon](https://github.com/st3fan/dovecot-xaps-daemon) project will enable push email for iOS devices that talk to your Dovecot 2.0.x IMAP server.



Installation on FreeBSD 10
==========================

Prerequisites
-------------
Please read carefully the instructions on the [dovecot-xaps-daemon](https://github.com/st3fan/dovecot-xaps-daemon)project.
This assumes that you have the exported `certificate.pem` and `key.pem` files in your home directory.


I used the installation within following environment:
* FreeBSD 10.3
* dovecot 2
* xaps dovecot2-plugin [dovecot-xaps-plugin](https://github.com/st3fan/dovecot-xaps-plugin)
* using BASH and shell environment

The daemon is written in [Go](http://golang.org/doc/install#install) and best build with the [GB](https://getgb.io/docs/install/) tool.
I usually don't use this labguage and tools, wherefor I'll install them into a temporary location and remove them afterwards again


Prepare Build environment
```
mkdir -p /tmp/xaps-build/
cd /tmp/xaps-build/

#Install GO environment
fetch https://storage.googleapis.com/golang/go1.7.1.freebsd-amd64.tar.gz
tar zxvf go1.7.1.freebsd-amd64.tar.gz

export GOPATH=/tmp/xaps-build/work
export GOROOT=/tmp/xaps-build/go
export PATH=$PATH:$GOROOT/bin

#Install GB environment
go get github.com/constabulary/gb/...
export PATH=$PATH:$GOPATH/bin
```

Compile and Installation
--------------------------
```
mkdir -p /tmp/xaps-build/
cd /tmp/xaps-build/

# get additional files and patches
git clone https://github.com/gitze/dovecot-xaps-freebsd.git


# get and compile daemon source, install daemon
git clone https://github.com/st3fan/dovecot-xaps-daemon.git
cd dovecot-xaps-daemon
gb build all

mkdir -p /usr/local/etc/xapsd
cp cmd/xapsd /usr/local/bin

# install startup script and enable daemon
cp /tmp/xaps-build/dovecot-xaps-freebsd/daemon/rc-script/xaps /usr/local/etc/rc.d/
echo 'xapsd_enable="YES"' >> /etc/rc.conf
echo 'xapsd_debug="YES"' >> /etc/rc.conf

cp $HOME/key.pem /usr/local/etc/xapsd
cp $HOME/certificate.pem /usr/local/etc/xapsd
chmod 600 /usr/local/etc/xapsd/key.pem
chmod 600 /usr/local/etc/xapsd/certificate.pem
```
