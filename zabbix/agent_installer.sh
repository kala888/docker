yum install -y gcc gcc-c++
cd /tmp
groupadd zabbix-agent
useradd -g zabbix-agent zabbix-agent

wget http://jaist.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Development/3.0.0alpha5/zabbix-3.0.0alpha5.tar.gz
tar xvf zabbix-3.0.0alpha5.tar.gz
cd zabbix-3.0.0alpha5
./configure --prefix=/usr/local/zabbix-agent --enable-agent
make install