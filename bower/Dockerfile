FROM node:5.11
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/22/2015 23:11

#Set the registry to taobao
RUN echo "Set registry to taobao.org, install npm modules" \
	&& npm config set registry http://registry.npm.taobao.org 
#Install bower
RUN npm install -g bower

