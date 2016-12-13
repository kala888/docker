#!/bin/bash
[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
# url=$DOWNLOAD_SERVER/docker/apps/gradle/gradle-3.2.1-bin.zip
url=https://downloads.gradle.org/distributions/gradle-3.2.1-bin.zip
#url=https://downloads.gradle.org/distributions/gradle-3.2.1-bin.zip
echo "start downloading ${url}"
wget -q $url

#Install Gradle
unzip -q /softwares/gradle-3.2.1-bin.zip -d /opt/
chmod -R 755 /opt/gradle-3.2.1

ln -s /opt/gradle-3.2.1 /opt/gradle
echo "export GRADLE_HOME=/opt/gradle" >> /root/.bash_profile
echo "export PATH=\$GRADLE_HOME/bin:$PATH" >> /root/.bash_profile
source /root/.bash_profile

rm -rf /softwares/*
