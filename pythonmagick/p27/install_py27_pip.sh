#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

yum -y install python-devel openssl openssl-devel gcc sqlite-devel

#download python2.7
wget -q https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
tar -xvf Python-2.7.9.tgz 
cd Python-2.7.9
./configure --prefix=/usr/local/python2.7 --with-threads --enable-shared
make
make install altinstall
ln -s /usr/local/python2.7/lib/libpython2.7.so /usr/lib
ln -s /usr/local/python2.7/lib/libpython2.7.so.1.0 /usr/lib
ln -s /usr/local/python2.7/bin/python2.7 /usr/local/bin
/sbin/ldconfig -v

cd /usr/bin
ln -s /usr/local/python2.7/bin/python2.7

#install pip
cd /softwares
wget -q https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
cd /usr/bin
ln -s /usr/local/python2.7/bin/pip

#clean
rm -rf /softwares/*