FROM centos/basic
MAINTAINER Frank Zhou (email:frankzhou@aaxischina.com)
ENV REFRESHED_AT 4/25/2016 16:11

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH


#EXPOSE Ports
EXPOSE 22 

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
