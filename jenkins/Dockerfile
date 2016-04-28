FROM centos/basic
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/22/2016 23:52

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

#Install the needed softwares
#RUN yum -y install unzip  && yum -y clean all

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ADD ./jenkins /etc/init.d/
RUN chkconfig --add jenkins
RUN chkconfig jenkins on

#Add the supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 18080 18009

#Make it executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

