#!/bin/sh

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in java/jdk1.6.0_34.zip \
              ant/apache-ant-1.7.1.zip \
              supervisord/install_supervisord.sh \
              endeca/docker_endeca_312.zip; \
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

chmod -R 755 /softwares

#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.6.0_34.zip -d /opt/java 
chmod -R 755 /opt/java
ln -s /opt/java/jdk1.6.0_34 /opt/java/jdk

echo "export JAVA_HOME=/opt/java/jdk" >> /home/docker/.bash_profile 
echo "export PATH=/opt/java/jdk/bin:\$PATH" >> /home/docker/.bash_profile 

#Install ANT
mkdir /opt/ant
unzip -q /softwares/apache-ant-1.7.1.zip -d /opt/ant
chmod -R 755 /opt/ant

echo "export ANT_HOME=/opt/ant/apache-ant-1.7.1" >> /home/docker/.bash_profile 
echo "export ANT_OPTS=\"-Xms768m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=768m\"" >> /home/docker/.bash_profile 
echo "export PATH=/opt/ant/apache-ant-1.7.1/bin:\$PATH" >> /home/docker/.bash_profile 

#Install Endeca
unzip -q docker_endeca_312.zip -d /opt/
chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

rm -rf /opt/endeca/ToolsAndFrameworks/3.1.2/server/workspace/state/sling

echo "export ENDECA_CONF=/opt/endeca/PlatformServices/workspace" >>  /home/docker/.bash_profile
echo "source /opt/endeca/PlatformServices/6.1.4/setup/installer_sh.ini" >> /home/docker/.bash_profile
echo "source /opt/endeca/MDEX/6.4.1.2/mdex_setup_sh.ini" >> /home/docker/.bash_profile

#Install supervisord
sh /softwares/install_supervisord.sh

#Cleanup softwares
yum -y clean all
rm -rf /softwares/*
