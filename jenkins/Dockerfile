FROM centos/git
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 09/25/2015

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ADD ./dockerjenkins.sh /usr/local/bin/dockerjenkins.sh
RUN chmod +x /usr/local/bin/dockerjenkins.sh

EXPOSE 8080

#Make it executable
ENTRYPOINT [ "/usr/local/bin/dockerjenkins.sh" ]
