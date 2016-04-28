#!/bin/bash
mount -a
#1.remove the IPV6 host;2.replace the fakehost to real host,fakehost is just a flag to indetify the realhost name line;
echo "setting real hostname to /etc/hosts"
rm -rf /fakehosts && cp /etc/hosts /fakehosts \
&& sed -i '/::1/d' /fakehosts \
&& sed -i '/127\.0\.0\.1 fakehost/d' /fakehosts && echo "127.0.0.1 fakehost `hostname`" >>/fakehosts \
&& cat /fakehosts >/etc/hosts

source /root/.bash_profile

echo "Starting Oracle Database:"
/opt/oracle/11gR2/bin/dbstart $ORACLE_HOME
# DON't Add any more scripts after start oracle, it will be cause a retry issue.
[ -f /oracle_setting.sql ] && sqlplus / as sysdba @/oracle_setting.sql && rm -rf /oracle_setting.sql


