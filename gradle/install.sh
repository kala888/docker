#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
 url=$DOWNLOAD_SERVER/docker/apps/gradle/gradle-2.11-all.zip && echo "start downloading ${url}" && wget -q $url
ls -l
chmod -R 755 /softwares

#Install Gradle
unzip -q /softwares/gradle-2.11-all.zip -d /opt/
chmod -R 755 /opt/gradle-2.11

ln -s /opt/gradle-2.11 /opt/gradle
echo "export GRADLE_HOME=/opt/gradle" >> /root/.bash_profile
echo "export PATH=\$GRADLE_HOME/bin:$PATH" >> /root/.bash_profile
source /root/.bash_profile

rm -rf /softwares/*
