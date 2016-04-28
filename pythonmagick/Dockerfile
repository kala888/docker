FROM apache:centos7
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/23/2016 00:04

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

# Install python-devel
RUN yum install -y python-devel && yum -y clean all

# Install ImageMagic 
RUN yum install -y ImageMagick* && yum -y clean all
RUN yum install -y ImageMagick-devel ImageMagick-c++ ImageMagick-c++-devel && yum -y clean all

RUN yum -y install epel-release
# Install pip
RUN echo "test"
#RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y python-pip && yum -y clean all
RUN pip install --upgrade pip

# Install Wand
RUN pip install Wand

RUN yum install -y gcc gcc-c++ && yum -y clean all

ADD ./install.sh /install.sh
RUN sh /install.sh

#Install imgresizehandler2
ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD pythonhandler /etc/httpd/pythonhandler/
RUN mkdir /var/www/html/output && chmod 755 /var/www/html/output -R && chown apache:apache /var/www/html/output -R
RUN mkdir /var/www/html/images

#Add a test image
ADD images/rose.jpg /var/www/html/images/

#Set the work directory
WORKDIR /

#Export Ports
EXPOSE 22 80

