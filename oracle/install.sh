#!/bin/sh

[ ! -e /softwares ] && mkdir /softwares
cd /softwares

#ENV DOWNLOAD_SERVER http://172.17.3.91/
for plugin in supervisord/install_supervisord.sh \
              oracle/oracle_11.2.0.1_linux64_green.zip ; \
 do url=$DOWNLOAD_SERVER/docker/apps/${plugin} && echo "start downloading ${url}" && wget -q $url ; done

#uncompress the zip file
echo "uncompress the zip file"
unzip -q /softwares/oracle_11.2.0.1_linux64_green.zip -d /opt/


#Add the oracle groups and user
echo "add new user : oracle"
groupadd oinstall
groupadd dba
useradd -m -s /bin/bash -g oinstall -G dba oracle
gpasswd -a oracle oinstall
echo -e "oracle\noracle" | passwd oracle

chown -R oracle:oinstall /opt/oracle
chmod -R 755 /opt/

#Set the system parameters
echo "oracle              soft    nproc   2047" >>/etc/security/limits.conf 
echo "oracle              hard    nproc   16384" >>/etc/security/limits.conf 
echo "oracle              soft    nofile  10240" >>/etc/security/limits.conf 
echo "oracle              hard    nofile  65536" >>/etc/security/limits.conf 
echo "oracle              soft    stack   10240" >> /etc/security/limits.conf

#Resize the shm
sed -i '/\/dev\/shm/s/defaults/defaults,size=4g/' /etc/fstab

#Set environment variables
echo "export ORACLE_BASE=/opt/oracle" >> /home/oracle/.bash_profile
echo "export ORACLE_HOME=\$ORACLE_BASE/11gR2" >> /home/oracle/.bash_profile
echo "export ORACLE_HOME_LISTENER=\$ORACLE_HOME" >> /home/oracle/.bash_profile
echo "export ORACLE_SID=orcl" >> /home/oracle/.bash_profile
echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /home/oracle/.bash_profile

#dbstart configuration
echo "orcl:/opt/oracle/11gR2:Y" >> /etc/oratab

#Install supervisord
sh /softwares/install_supervisord.sh

#echo cleanup softwares
rm -rf /softwares/*
