FROM centos/git
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 11/3/2015

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

#Install the needed softwares
RUN yum -y install unzip  && yum -y clean all

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh


#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 8080

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

