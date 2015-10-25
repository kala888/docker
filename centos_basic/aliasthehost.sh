#!/bin/bash
# this script can add host alias for container: eg. 172.17.0.1 acrs_endeca  => 172.17.0.1 acrs_endeca endecacontainer
#container_name is the common container name that will add to /etc/hosts
#realcontianer_name is the source contaienr name

container_name=$1
real_container_name=$2

if [ -z "$container_name" ] || [ -z "$real_container_name" ]
 then
 echo "container_name and real_container_name can not be empty!!"
 exit 1
fi

a=`cat /hosts | grep $real_container_name | awk '{print $1}'`
if [ -z "$a" ]
 then
 echo "can not find the IP for $real_container_name"
 exit 1
fi

rm -rf /fakehosts && cp hosts /fakehosts
sed -i "/$real_container_name/d" /fakehosts
sed -i "/$container_name/d" /fakehosts
echo "$a $real_container_name $container_name" >>/fakehosts
echo "$a $real_container_name.bridge $container_name.bridge" >>/fakehosts
cat /fakehosts > /etc/hosts
cat /etc/hosts
rm -rf /fakehosts