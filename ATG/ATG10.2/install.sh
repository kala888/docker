#!/bin/bash

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in java/jdk1.6.0_34.zip \
              jboss/jboss-5.1.0.GA.zip \
              ant/apache-ant-1.7.1.zip \
              oracle/oracle-instantclient11.2-basic-11.2.0.1.0-1.x86_64.zip \
              oracle/oracle-instantclient11.2-sqlplus-11.2.0.1.0-1.x86_64.zip \
              atg/atg10.2.zip;\
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

chmod -R 755 /softwares

#Begin the install
#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.6.0_34.zip -d /opt/java 
ln -s /opt/java/jdk1.6.0_34 /opt/java/jdk
chown -R docker:docker /opt/java
chmod -R 755 /opt/java

echo "export JAVA_HOME=/opt/java/jdk" >> /home/docker/.bash_profile 
echo "export PATH=/opt/java/jdk/bin:\$PATH" >> /home/docker/.bash_profile 

#Install ANT
mkdir /opt/ant
unzip -q /softwares/apache-ant-1.7.1.zip -d /opt/ant
chown -R docker:docker /opt/ant
chmod -R 755 /opt/ant

echo "export ANT_HOME=/opt/ant/apache-ant-1.7.1" >> /home/docker/.bash_profile 
echo "export ANT_OPTS=\"-Xms768m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=768m\"" >> /home/docker/.bash_profile 
echo "export PATH=/opt/ant/apache-ant-1.7.1/bin:\$PATH" >> /home/docker/.bash_profile 

#Install JBOSS
mkdir /opt/jboss
unzip -q /softwares/jboss-5.1.0.GA.zip -d /opt/jboss
chown -R docker:docker /opt/jboss
chmod -R 755 /opt/jboss
echo "export JBOSS_HOME=/opt/jboss/jboss-5.1.0.GA" >> /home/docker/.bash_profile 

#Install oracleclient
mkdir -p /opt/oracleclient
unzip -q /softwares/oracle-instantclient11.2-basic-11.2.0.1.0-1.x86_64.zip -d /opt/oracleclient 
unzip -q /softwares/oracle-instantclient11.2-sqlplus-11.2.0.1.0-1.x86_64.zip -d /opt/oracleclient 
chown -R docker:docker /opt/oracleclient
chmod -R 755 /opt/oracleclient

echo "export ORACLE_HOME=/opt/oracleclient/instantclient_11_2" >> /home/docker/.bash_profile 
echo "export LD_LIBRARY_PATH=/opt/oracleclient/instantclient_11_2" >> /home/docker/.bash_profile 
echo "export TNS_ADMIN=/opt/oracleclient/instantclient_11_2" >> /home/docker/.bash_profile 
echo "export PATH=/opt/oracleclient/instantclient_11_2:\$PATH" >> /home/docker/.bash_profile 

#Install ATG
unzip -q /softwares/atg10.2.zip -d /opt/ATG/
echo "ATGJRE=/opt/java/jdk/bin/java;export ATGJRE" > /opt/ATG/ATG10.2/home/localconfig/dasEnv.sh
echo "JBOSS_HOME=/opt/jboss/jboss-5.1.0.GA;export JBOSS_HOME" >> /opt/ATG/ATG10.2/home/localconfig/dasEnv.sh 
echo "JBOSS_VERSION=5.1.0.GA;export JBOSS_VERSION" >> /opt/ATG/ATG10.2/home/localconfig/dasEnv.sh

echo "export DYNAMO_ROOT=/opt/ATG/ATG10.2" >> /home/docker/.bash_profile
echo "export DYNAMO_HOME=/opt/ATG/ATG10.2/home" >> /home/docker/.bash_profile

chown -R docker:docker /opt/ATG
chmod -R 755 /opt/ATG

#Remove the install sources
rm -rf /softwares/*