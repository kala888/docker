#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
url=$DOWNLOAD_SERVER/docker/apps/java/jdk-8u73-linux-x64.gz && echo "start downloading ${url}" && wget -q $url
ls -l
chmod -R 755 /softwares

#Install JAVA
echo "Install JAVA"
mkdir /opt/java
tar xvzf /softwares/jdk-8u73-linux-x64.gz
mv  /softwares/jdk1.8.0_73  /opt/
chmod -R 755 /opt/jdk1.8.0_73

ln -s /opt/jdk1.8.0_73  /opt/jdk
echo "export JAVA_HOME=/opt/jdk" >> /root/.bash_profile 
echo "export PATH=/opt/jdk/bin:$PATH" >> /root/.bash_profile  
source /root/.bash_profile

rm -rf /softwares/*
