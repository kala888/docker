FROM centos:centos6
MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)
ENV REFRESHED_AT 10/13/2015 14:50

#Change the root password
RUN echo -e "123abcABC\n123abcABC" | passwd root

#Install the needed softwares
RUN yum -y install glibc.i686 tar wget unzip python-setuptools dos2unix openssh-server telnet which sudo libaio* \
    && yum -y clean all
	
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
