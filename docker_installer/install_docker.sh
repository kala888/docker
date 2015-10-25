#!/bin/bash
#install docker
sudo echo "start install docker and tools"

if [ ! -f /usr/bin/docker ] 
then 
	curl -sSL https://get.daocloud.io/docker | sh
else
	echo "found docker skip install"
fi

#install nsenter
if [ ! -f /usr/local/bin/nsenter ] 
then
	echo "install nsenter"
	mkdir temp_software
	cd temp_software
	wget https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz
	tar -zxf util-linux-2.24.tar.gz 
	cd util-linux-2.24
	./configure --without-ncurses
	make nsenter
	sudo cp nsenter /usr/local/bin
	cd ..
	rm -rf temp_software
fi
#install docker-enter
if [ ! -f ~/.bashrc_docker ]
then 
	echo "install docker-enter"
	cp bashrc_docker ~/.bashrc_docker
	echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >> ~/.bashrc 
fi

#install tools
echo "install tools to /usr/local/bin"
sudo cp docker* /usr/local/bin

echo "If it is the first time to install docker, please run"
echo "\t sudo usermod -aG docker `whoami`"
echo "Completed!!"
