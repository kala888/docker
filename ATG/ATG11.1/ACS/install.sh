#!/bin/bash

cd /softwares
echo "install nodejs to /opt/nodejs"
wget -q http://docker.aaxisaws.com/docker/apps/nodejs/node-v0.10.32-linux-x64.zip
unzip node-v0.10.32-linux-x64.zip -d /opt/
chown -R docker:docker /opt/node-v0.10.32-linux-x64
ln -s /opt/node-v0.10.32-linux-x64 /opt/nodejs

echo "export PATH=/opt/nodejs/bin/:\$PATH" >> /home/docker/.bash_profile
source /home/docker/.bash_profile

#clea
yum -y clean all
rm -rf  /softwares/*
