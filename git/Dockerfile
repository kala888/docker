FROM centos:centos6
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 11/1/2015 11:11

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh


#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
