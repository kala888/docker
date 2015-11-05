FROM centos/jenkins
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 09/07/2015

RUN curl -s https://get.docker.com/ | sh

VOLUME /var/lib/docker

ADD ./dockerjenkins.sh /usr/local/bin/dockerjenkins.sh
RUN chmod +x /usr/local/bin/dockerjenkins.sh
#Make it executable
ENTRYPOINT [ "/usr/local/bin/dockerjenkins.sh" ]
