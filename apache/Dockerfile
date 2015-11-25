FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 11/25/2015 11:50

ENV DOWNLOAD_SERVER http://172.17.3.91

#Install 
RUN yum -y install httpd* mod_ssl && yum -y clean all

RUN cd /etc/httpd/modules && wget -q $DOWNLOAD_SERVER/docker/apps/apache/mod_jk.so
RUN cd /etc/httpd/modules && wget -q $DOWNLOAD_SERVER/docker/apps/apache/mod_perl.so
RUN chmod -R 755  /etc/httpd/modules/
RUN cd /tmp/ && wget -q  $DOWNLOAD_SERVER/docker/apps/apache/vendor_perl.zip && unzip -d /usr/lib64/perl5/ vendor_perl.zip && rm -rf /tmp/vendor_perl.zip


#Install supervisord
RUN wget -q $DOWNLOAD_SERVER/docker/apps/supervisord/install_supervisord.sh && sh install_supervisord.sh && rm -rf install_supervisord.sh
#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

#Set the work directory
WORKDIR /

#Export Ports
EXPOSE 22 80

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]
