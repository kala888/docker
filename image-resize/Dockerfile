FROM apache
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/22/2015 23:44

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

#Install the needed softwares
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

#Install Handlers
RUN mkdir -p /etc/httpd/Apache
RUN curl -so /etc/httpd/Apache/ImageResizeHandler.pm  $DOWNLOAD_SERVER/docker/apps/ImageMagick/ImageResizeHandler.pm 
RUN curl -so /etc/httpd/Apache/ProductImageListHandler.pm  $DOWNLOAD_SERVER/docker/apps/ImageMagick/ProductImageListHandler.pm 

#Set the work directory
WORKDIR /

#Export Ports
EXPOSE 22 80

