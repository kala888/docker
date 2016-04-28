FROM centos:centos6.7
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 1/22/2016 14:50

#Do update 
RUN yum -y update &&  yum -y clean all

#Install the needed softwares
RUN yum -y install passwd ping glibc.i686 tar wget unzip python-setuptools dos2unix openssh-server telnet which sudo libaio* \
    && yum -y clean all
	

#Change the root password
RUN echo -e "123abcABC\n123abcABC" | passwd root

#Set the ssh connection
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
    
#Create the user docker
RUN useradd docker \
   && echo -e "docker\ndocker" | passwd docker \
   && echo "docker              soft    nproc   2047"  >>/etc/security/limits.conf \
   && echo "docker              hard    nproc   16384" >>/etc/security/limits.conf \
   && echo "docker              soft    nofile  10240" >>/etc/security/limits.conf \
   && echo "docker              hard    nofile  65536" >>/etc/security/limits.conf \
   && echo "docker              soft    stack   10240" >> /etc/security/limits.conf

#Add the created user into sudoer
RUN echo "docker        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
