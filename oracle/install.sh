#!/bin/sh

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#ENV DOWNLOAD_SERVER http://172.17.3.91/
for plugin in supervisord/install_supervisord.sh \
              oracle/oracle_11.2.0.3_linux64_green.zip ; \
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

#uncompress the zip file
echo "uncompress the zip file"
unzip -q /softwares/oracle_11.2.0.3_linux64_green.zip -d /opt/


#Add the oracle groups and user
groupadd dba
usermod -g dba -G dba root

chown -R root:dba /opt/oracle
chmod -R 775 /opt/

#Resize the shm,in docker1.10 this was fix by --shm-size=2g
#sed -i '/\/dev\/shm/s/defaults/defaults,size=4g/' /etc/fstab

#Set environment variables
echo "export ORACLE_BASE=/opt/oracle" >> /root/.bash_profile
echo "export ORACLE_HOME=\$ORACLE_BASE/11gR2" >> /root/.bash_profile
echo "export ORACLE_HOME_LISTENER=\$ORACLE_HOME" >> /root/.bash_profile
echo "export ORACLE_SID=orcl" >> /root/.bash_profile
echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /root/.bash_profile

#dbstart configuration
echo "orcl:/opt/oracle/11gR2:Y" >> /etc/oratab

#Install supervisord
sh /softwares/install_supervisord.sh

#echo cleanup softwares
rm -rf /softwares/*
