FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/22/2016 19:00

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com


#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

#Change TimeZone
RUN export "TZ=Asia/Shanghai" >> /root/.bash_profile

#Add startup scripts
ADD /startuporacle.sh /startuporacle.sh
RUN chmod 755 /startuporacle.sh

#Add setting sql
ADD oracle_setting.sql /oracle_setting.sql
#Add  supervisord configuration
ADD ./supervisord.conf /etc/supervisord.conf

#EXPOSE Ports
EXPOSE 22 1521

#Set the container executable
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n"]

