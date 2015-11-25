FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 11/25/2015 15:00

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ENV HOSTNAME localhost

#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh


#Add the endeca control shells
ADD startupendeca.sh /startupendeca.sh
ADD stopendeca.sh /stopendeca.sh
RUN chmod 755 /*.sh



#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

#Export Ports
EXPOSE 22 8006 8500 8888 8090 15000 15001 15002 16000 16002 16010 16011 17000 17002 16012

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

