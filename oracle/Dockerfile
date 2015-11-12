FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 10/13/2015

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com


#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

#Change TimeZone
RUN export TZ=Asia/Shanghai" >> /home/oracle/.bash_profile

#Add the startup shell
ADD /startuporacle.sh /startuporacle.sh
RUN chmod 755 /startuporacle.sh

#set oracle configuration
ADD ./oracle_setting.sql /oracle_setting.sql

#Add  supervisord configuration
ADD ./supervisord.conf /etc/supervisord.conf

#EXPOSE Ports
EXPOSE 22 1521

#Set the container executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

