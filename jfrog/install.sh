#!/bin/sh

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#ENV DOWNLOAD_SERVER http://172.17.3.91/
for plugin in java/jdk1.7.0_15.zip \
			  supervisord/install_supervisord.sh \
              tools/jfrog-artifactory-pro-4.4.2.zip ; \
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

#uncompress the zip file

mkdir /opt/java
unzip -q /softwares/jdk1.7.0_15.zip -d /opt/java 
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk
chmod -R 755 /opt/java

echo "export JAVA_HOME=/opt/java/jdk" >> /root/.bashrc 
echo "export PATH=/opt/java/jdk/bin:\$PATH" >>  /root/.bashrc 

echo "uncompress the zip file"
unzip -q /softwares/jfrog-artifactory-pro-4.4.2.zip -d /opt/
cd /opt/artifactory-pro-4.4.2/bin
sh installService.sh


#Install supervisord
sh /softwares/install_supervisord.sh

#echo cleanup softwares
rm -rf /softwares/*
