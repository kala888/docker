

#1.Install basic libs
yum install -y glibc.i686 tar unzip wget dos2unix telnet libaio*
yum install -y httpd*
yum install -y gcc libjpeg libjpeg-devel libpng libpng-devel libtiff http-devel perl-parent perl-ExtUtils-Embed
yum groupinstall -y  "Development Tools"
yum install -y epel-release libpng* gcc-c++  openssl* git

#1.Install JDK
mkdir /opt/java
unzip -q /softwares/apps/java/jdk1.7.0_15.zip -d /opt/java 
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk

echo "export JAVA_HOME=/opt/java/jdk" >> /home/vagrant/.bashrc 
echo "export PATH=/opt/java/jdk/bin:\$PATH" >> /home/vagrant/.bashrc 


#2.Install JBOSS
mkdir /opt/jboss
unzip -q /softwares/apps/jboss/jboss-eap-6.1.zip -d /opt/jboss
echo "export JBOSS_HOME=/opt/jboss/jboss-eap-6.1" >> /home/vagrant/.bashrc 


#3.Install Ant
mkdir /opt/ant
unzip -q /softwares/apps/ant/apache-ant-1.7.1.zip -d /opt/ant
echo "export ANT_HOME=/opt/ant/apache-ant-1.7.1" >> /home/vagrant/.bashrc 
echo "export ANT_OPTS=\"-Xms768m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=768m\"" >> /home/vagrant/.bashrc 
echo "export PATH=/opt/ant/apache-ant-1.7.1/bin:\$PATH" >> /home/vagrant/.bashrc 

#4.Install Oracle client,sqlplu
mkdir -p /opt/oracleclient
unzip -q /softwares/apps/oracle/oracle-instantclient11.2-basic-11.2.0.1.0-1.x86_64.zip -d /opt/oracleclient 
unzip -q /softwares/apps/oracle/oracle-instantclient11.2-sqlplus-11.2.0.1.0-1.x86_64.zip -d /opt/oracleclient 
echo "export ORACLE_HOME=/opt/oracleclient/instantclient_11_2" >> /home/vagrant/.bashrc 
echo "export LD_LIBRARY_PATH=/opt/oracleclient/instantclient_11_2" >> /home/vagrant/.bashrc 
echo "export PATH=/opt/oracleclient/instantclient_11_2:\$PATH" >> /home/vagrant/.bashrc 
echo "export TZ=Asia/Shanghai" >> /home/vagrant/.bashrc  

#5.Install ATG
unzip -q /softwares/apps/atg/atg11.1.zip -d /opt/ATG/
echo "ATGJRE=/opt/java/jdk/bin/java;export ATGJRE" > /opt/ATG/ATG11.1/home/localconfig/dasEnv.sh
echo "JBOSS_HOME=/opt/jboss/jboss-eap-6.1;export JBOSS_HOME" >> /opt/ATG/ATG11.1/home/localconfig/dasEnv.sh 
echo "JBOSS_VERSION=6.1.0;export JBOSS_VERSION" >> /opt/ATG/ATG11.1/home/localconfig/dasEnv.sh

echo "export DYNAMO_ROOT=/opt/ATG/ATG11.1" >> /home/vagrant/.bashrc 
echo "export DYNAMO_HOME=/opt/ATG/ATG11.1/home" >> /home/vagrant/.bashrc 


#6.Install Nodjs
unzip -q /softwares/apps/nodejs/node-v0.10.32-linux-x64.zip -d /opt/
ln -s /opt/node-v0.10.32-linux-x64 /opt/nodejs
echo "export PATH=/opt/nodejs/bin/:\$PATH" >> /home/vagrant/.bashrc

#7.Change the file owner for /opt
chown vagrant:vagrant -R /opt
chmod 755 -R /opt

#8.Npm update
source /home/vagrant/.bashrc
npm config set registry http://registry.npm.taobao.org
npm install -g bower
npm install -g gulp

#9.Install ImageMigick
unzip -q /softwares/apps/ImageMagick/ImageMagick-6.9.2-4.zip -d /tmp/
cd /tmp/ImageMagick-6.9.2-4
./configure --with-quantum-depth=16 --with-perl
make perl-sources
make install
ldconfig
cd PerlMagick/
perl Makefile.PL
make
make install
/sbin/ldconfig /usr/local/lib
ldconfig /usr/local/lib

#10.Install Image Resize Handler
cp /softwares/apps/modperl/mod_perl.so /etc/httpd/modules/
mkdir /etc/httpd/Apache
cp /softwares/apps/ImageMagick/*.pm /etc/httpd/Apache
chmod 755 -R /etc/httpd/Apache
mkdir -p /var/www/html/images/large
chmod 777 -R /var/www/html/images

unzip /softwares/apps/modperl/vendor_perl.zip -d /tmp
[ ! -f /usr/share/perl5/vendor_perl ] && mkdir -p /usr/share/perl5/vendor_perl
mv /tmp/vendor_perl/* /usr/share/perl5/vendor_perl/

service httpd restart
chkconfig httpd on
chmod 755 -R /var/log/httpd


-----------------------

cd /vagrant/scripts

vi vagrant.properties
	database.ip=172.17.118.135
	current.environment=Docker
	
sh /vagrant/docker/scripts/build_apache.sh
ant all

echo "172.17.118.135 beacon-oracle oraclecontainer beacon-endeca endecacontainer" >>/etc/hosts
echo "127.0.0.1 beacon-atg atgcontainer beacon-apache apachecontainer" >>/etc/hosts




