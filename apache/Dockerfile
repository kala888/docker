FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 09/21/2015 11:50

ENV DOWNLOAD_SERVER http://172.17.3.91

#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh


#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

#Set the work directory
WORKDIR /

#Export Ports
EXPOSE 22 80

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]
