#!/bin/bash
# if you are a docker developer add "127.0.0.1 docker.aaxisaws.com" to you hosts, in other Doockerfile you can set docker.aaxisaws.com as the download site
# this apache will use ~/docker/softwares/ as a cache folder for download files


#fakehost is just a flag to indetify the realhost name line;
docker_name=apache_cache
softwares_cache=~/docker/softwares/

apache_handler=~/docker/apache/Apache
apache_conf=~/docker/apache/httpd.conf

a=`cat /etc/default/docker|grep $(ifconfig docker0 | egrep -o "inet addr:[^ ]*" | grep -o "[0-9.]*")`
if [ ! -n "$a" ]
then
 echo "please set you ip to docker dns parameter which in the file /etc/default/docker and restart you docker. Your ip is : "
 ifconfig docker0 | egrep -o "inet addr:[^ ]*" | grep -o "[0-9.]*"|awk "{print $1}"
 exit 0
fi


echo -e "setting /etc/hosts: $(ifconfig docker0 | egrep -o "inet addr:[^ ]*" | grep -o "[0-9.]*") fakehost docker.aaxisaws.com"
rm -rf /fakehosts && cp /etc/hosts /fakehosts \
&& sed -i '/docker\.aaxisaws\.com/d' /fakehosts \
&& sed -i '/[0-9].* fakehost/d' /fakehosts \
&& echo "$(ifconfig docker0 | egrep -o "inet addr:[^ ]*" | grep -o "[0-9.]*") fakehost docker.aaxisaws.com" >>/fakehosts \
&& cat /fakehosts >/etc/hosts

echo "Restart the DSN Cache"
if [ ! -e /etc/init.d/dnsmasq ]
then
  yum -y install dnsmasq
fi
   /etc/init.d/dnsmasq restart
echo "Starup the Apache for a docker developer"
echo "****************************************"
echo "Container name : \033[31m \033[05m $docker_name \033[0m"
echo "Softwares cache file folder : $softwares_cache"
echo "Apache handler path : $apache_handler"
echo "Apache conf  : $apache_conf"
echo "****************************************"

if (docker ps|grep $docker_name); then
   echo "The Apache is still alive. Do you want to\033[31m\033[05m Restart\033[0m it?"
   read -p " y/N " answer;
   if  [ "$answer" = "y" ] ||  [ "$answer" = "Y" ] ; then
   	   docker stop $docker_name;
   else
   	   exit 0
   fi
fi

if (docker ps -a|grep $docker_name); then
   echo "The container docker_apache was found, it will be start by : docker start $docker_name"
   docker start $docker_name

   echo "Start successful"
   exit 0
fi

if ! (docker ps -a|grep $docker_name); then
   echo "New $docker_name will be create"
   docker run -d --privileged \
	-v $apache_handler:/etc/httpd/Apache:ro \
	-v $apache_conf:/etc/httpd/conf/httpd.conf:ro \
	-v $softwares_cache:/var/www/html/docker/ \
	-p 80:80 --name $docker_name apache
   
   echo "Start successful"
   exit 0
fi
