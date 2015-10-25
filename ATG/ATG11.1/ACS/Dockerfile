FROM atg/111
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 10/21/2015

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

#Install the needed softwares
RUN yum -y groupinstall "Development Tools" &&  yum -y clean all
RUN yum -y install epel-release libpng* gcc-c++  openssl* git && yum -y clean all
#RUN rpm -ivh http://docker.aaxisaws.com/docker/apps/nodejs/epel-release-6-8.noarch.rpm 


ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

#Set the registry to taobao
RUN echo "Set registry to taobao.org, install npm modules" \
	&& source /home/docker/.bash_profile \
	&& npm config set registry http://registry.npm.taobao.org 
#Install bower
RUN source /home/docker/.bash_profile && npm install -g bower

#Install gulp
RUN source /home/docker/.bash_profile && npm install -g gulp

#Install a aliasthehost
RUN [ ! -e /opt/tools/ ] && mkdir -p /opt/tools/
RUN curl -o /opt/tools/aliasthehost.sh $DOWNLOAD_SERVER/docker/apps/tools/aliasthehost.sh

#EXPOSE Ports
EXPOSE 22 8080 8180 8280 8380 8787 8009

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
