FROM jdk:1.8.0_73
MAINTAINER Kala Liu (email:kalaliu@aaxiscommerce.com)
ENV REFRESHED_AT 4/25/2016 16:11

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ENV WILDFLY_HOME /opt/wildfly
ENV PATH $WILDFLY_HOME:$PATH

#Registry mysql
ADD ./modules/ /opt/wildfly/modules/system/layers/base/com/ 


#EXPOSE Ports
EXPOSE 22 8080 8787 8009

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
