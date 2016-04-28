FROM centos/basic
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/23/2016 00:04

ENV DOWNLOAD_SERVER http://docker.aaxisaws.com

RUN yum -y install httpd* && yum -y clean all

ADD install_py27_pip.sh /install_py27_pip.sh
RUN sh /install_py27_pip.sh && rm -rf /install_py27_pip.sh

# Change python26 to python27
ADD change26to27.sh /change26to27.sh
RUN sh /change26to27.sh && rm -rf /change26to27.sh

# Install ImageMagic 
RUN yum install -y ImageMagick* && yum -y clean all
RUN yum install -y ImageMagick-devel ImageMagick-c++ ImageMagick-c++-devel && yum -y clean all

# Install Wand
RUN pip install Wand

RUN yum install -y gcc gcc-c++ && yum -y clean all

ADD ./install_mod_python.sh /install_mod_python.sh
RUN sh /install_mod_python.sh && rm -rf /install_mod_python.sh

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

