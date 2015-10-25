#!/bin/bash

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in ImageMagic/ImageMagick-6.9.2-4.zip  ;\
 do 
 	url=$DOWNLOAD_SERVER/docker/apps/${plugin}
 	echo "start downloading ${url}"
 	wget -q $url 
 done

chmod -R 755 /softwares

#Install apache by yum
yum -y  install gcc libjpeg libjpeg-devel libpng libpng-devel libtiff http-devel perl-parent perl-ExtUtils-Embed

unzip ImageMagick-6.9.2-4.zip
cd ImageMagick-6.9.2-4
./configure --with-quantum-depth=16 --with-perl
make perl-sources
make install
ldconfig
cd PerlMagick/
perl Makefile.PL
make
make install
/sbin/ldconfig /usr/local/lib
ldconfig /usr/local/lib


#Cleanup softwares
yum -y clean all
rm -rf /softwares/*
