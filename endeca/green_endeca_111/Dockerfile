FROM centos/basic

MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)

ENV HOSTNAME localhost

ADD .   /softwares/
ADD ./install.sh /install.sh
RUN chmod 777 /softwares -R && chmod 777 /install.sh && chmod 777 /opt


USER docker
RUN sh install.sh

USER root
RUN yum -y install zip && yum -y clean all
