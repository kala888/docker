#!/bin/bash

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in java/jdk1.7.0_15.zip \
              jenkins/jenkins.war;\
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

chmod -R 755 /softwares

#Begin the install
#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.7.0_15.zip -d /opt/java 
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk
chmod -R 755 /opt/java

echo "export JAVA_HOME=/opt/java/jdk" >> /root/.bash_profile 
echo "export PATH=/opt/java/jdk/bin:\$PATH" >> /root/.bash_profile 


JENKINS_HOME =/opt/jenkins/data

mkdir -p $JENKINS_HOME/plugins
mv /softwares/jenkins.war /opt/jenkins/jenkins.war

RUN for plugin in chucknorris greenballs scm-api git-client git ws-cleanup ;\
    do wget -q -O $JENKINS_HOME/plugins/${plugin}.hpi $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi ; done

#Remove the install sources
rm -rf /softwares/*