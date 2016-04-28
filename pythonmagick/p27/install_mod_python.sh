#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in tools/mod_python-3.5.0_fixgitissue.tgz;\
  do url=$DOWNLOAD_SERVER/docker/apps/${plugin} 
  echo "start downloading ${url}"
  wget -q $url 
done

# Install mod_python
tar xvf mod_python-3.5.0_fixgitissue.tgz
cd mod_python-3.5.0
./configure --with-apxs=/usr/sbin/apxs 
make && make install
