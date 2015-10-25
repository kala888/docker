FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 10/23/2015 18:49:00

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

#For oracle client, we need set the TIMEZONE
RUN echo "export TZ=Asia/Shanghai" >> /home/docker/.bash_profile 

#EXPOSE Ports
EXPOSE 22 8080 8180 8280 8380 8787 8009

#Make it executable
CMD ["/usr/sbin/sshd", "-D"]
