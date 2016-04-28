FROM jdk:1.8.0_73
MAINTAINER Frank Zhou (email:frankzhou@aaxischina.com)
ENV REFRESHED_AT 4/25/2016 23:12

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ENV GRADLE_HOME /opt/gradle
ENV PATH $GRADLE_HOME/bin:$PATH

#EXPOSE Ports
EXPOSE 22

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
