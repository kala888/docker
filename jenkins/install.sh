#!/bin/bash

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in java/jdk1.7.0_15.zip \
              supervisord/install_supervisord.sh \
              jenkins/jenkins.war; \
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

chmod -R 755 /softwares

#Begin the install
#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.7.0_15.zip -d /opt/java 
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk
chmod -R 755 /opt/java

echo "export JAVA_HOME=/opt/java/jdk" >> /root/.bash_profile 
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /root/.bash_profile
source /root/.bash_profile

export JENKINS_HOME=/opt/jenkins/home

mkdir -p $JENKINS_HOME/plugins
mkdir -p $JENKINS_HOME/../log
mv /softwares/jenkins.war /opt/jenkins/jenkins.war

for plugin in chucknorris greenballs scm-api git-client git ws-cleanup ansicolor publish-over-ssh active-directory;\
    do
	echo "install plugin $plugin"
	wget -q -O $JENKINS_HOME/plugins/${plugin}.hpi $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; 
done

#Install supervisord
sh /softwares/install_supervisord.sh

#Remove the install sources
rm -rf /softwares/*
