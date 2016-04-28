FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 2/1/2015 23:52

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

#Install the needed softwares
ADD ./install.sh /install.sh
RUN sh /install.sh

ADD supervisord.conf /etc/supervisord.conf

#Set the work directory
WORKDIR /

#Export Ports
EXPOSE 22 80

