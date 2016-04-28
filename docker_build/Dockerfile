FROM gradle:2.11
MAINTAINER Kala Liu (email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 4/27/2016 16:12

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

RUN curl -sSL https://get.daocloud.io/docker | sh
RUN usermod -aG docker root



#EXPOSE Ports
EXPOSE 22

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
