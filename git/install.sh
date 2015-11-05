#!/bin/bash
mkdir /softwares
yum install -y tar wget curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker gcc 
yum -y clean all

#https://www.kernel.org/pub/software/scm/git/
cd /softwares
url="$DOWNLOAD_SERVER/docker/apps/git/git-2.0.5.tar.gz"
echo "start downloading ${url}"
wget -q $url

echo "install git"
tar xzf git-2.0.5.tar.gz
cd git-2.0.5
make prefix=/opt/git all
make prefix=/opt/git install

echo "export PATH=$PATH:/opt/git/bin" >> /etc/bashrc

rm -rf /softwares/*