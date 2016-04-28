#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
 url=$DOWNLOAD_SERVER/docker/apps/wildfly/wildfly-10.0.0.Final.zip && echo "start downloading ${url}" && wget -q $url 
ls -l
chmod -R 755 /softwares

#Install Wildfly
unzip -q /softwares/wildfly-10.0.0.Final.zip -d /opt
chmod -R 755 /opt/wildfly-10.0.0.Final

ln -s /opt/wildfly-10.0.0.Final /opt/wildfly
echo "export WILDFLY_HOME=/opt/wildfly" >> /root/.bash_profile
source /root/.bash_profile


rm -rf /softwares/*
