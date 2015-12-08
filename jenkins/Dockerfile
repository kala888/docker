FROM centos/git
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 12/7/2015 14:54

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

#Install the needed softwares
#RUN yum -y install unzip  && yum -y clean all

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ADD startupjenkins.sh /startupjenkins.sh

#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 18080 18009

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

