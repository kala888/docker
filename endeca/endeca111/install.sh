#!/bin/sh

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#Download softwares form docker server
for plugin in java/jdk1.7.0_15.zip \
              ant/apache-ant-1.7.1.zip \
              supervisord/install_supervisord.sh \
              endeca/green_endeca_111.zip; \
 do 
	url=$DOWNLOAD_SERVER/docker/apps/${plugin}
	echo "start downloading ${url}" 
	wget -q $url 
	ls -l 
 done

chmod -R 755 /softwares

#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.7.0_15.zip -d /opt/java 
chown -R docker:docker /opt/java
chmod -R 755 /opt/java
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk

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

#Install Endeca
unzip -q green_endeca_111.zip -d /opt/
chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

#rm -rf /opt/endeca/ToolsAndFrameworks/11.1.0/server/workspace/state/sling

echo "export ENDECA_CONF=/opt/endeca/PlatformServices/workspace" >>  /home/docker/.bash_profile
echo "source /opt/endeca/PlatformServices/11.1.0/setup/installer_sh.ini" >> /home/docker/.bash_profile
echo "source /opt/endeca/MDEX/6.5.1/mdex_setup_sh.ini" >> /home/docker/.bash_profile

#Install supervisord
sh /softwares/install_supervisord.sh

#Cleanup softwares
yum -y clean all
rm -rf /softwares/*
