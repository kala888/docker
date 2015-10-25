FROM centos/basic

MAINTAINER Kala Liu(email:kalaliu@aaxischina.com)

ENV HOSTNAME localhost
#Update the hosts
RUN echo "127.0.0.1 endeca.workbench endeca.mdex" >> /etc/hosts


#Attach the installation package to container
RUN mkdir /softwares
WORKDIR /softwares
ENV DOWNLOAD_SERVER http://172.17.3.91


RUN  FILE_PATH="jdk1.6.0_34.zip"      && [ ! -e $FILE_PATH ] && wget -q $DOWNLOAD_SERVER/apps/java/$FILE_PATH
RUN  FILE_PATH="apache-ant-1.7.1.zip" && [ ! -e $FILE_PATH ] && wget -q $DOWNLOAD_SERVER/apps/ant/$FILE_PATH
RUN  FILE_PATH="jboss-5.1.0.GA.zip"   && [ ! -e $FILE_PATH ] && wget -q $DOWNLOAD_SERVER/apps/jboss/$FILE_PATH


RUN chmod -R 755 /softwares

#Create the user docker
RUN useradd docker \
   && echo -e "docker\ndocker" | passwd docker

#Add the user docker into sudoer
RUN echo "docker        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

#Begin the install
WORKDIR /softwares

#Install JAVA
RUN mkdir /opt/java \
    && unzip -q /softwares/jdk1.6.0_34.zip -d /opt/java \
    && chown -R docker:docker /opt/java \
    && chmod -R 755 /opt/java \
    && ln -s /opt/java/jdk1.6.0_34 /opt/java/jdk


USER docker
ENV JAVA_HOME /opt/java/jdk
ENV PATH $JAVA_HOME/bin:$PATH 
RUN echo "export JAVA_HOME=/opt/java/jdk" >> /home/docker/.bash_profile \
    && echo "export PATH=/opt/java/jdk/bin:$PATH" >> /home/docker/.bash_profile \
    && source /home/docker/.bash_profile

#Install JBOSS
USER root
RUN mkdir /opt/jboss \
    && unzip -q /softwares/jboss-5.1.0.GA.zip -d /opt/jboss \
    && chown -R docker:docker /opt/jboss \
    && chmod -R 755 /opt/jboss
USER docker
ENV JBOSS_HOME /opt/jboss/jboss-5.1.0.GA
ENV JBOSS_VERSION 5.1.0.GA
RUN echo "export JBOSS_HOME=/opt/jboss/jboss-5.1.0.GA" >> /home/docker/.bash_profile \
    && echo "export JBOSS_VERSION=5.1.0.GA" >> /home/docker/.bash_profile \
    && source /home/docker/.bash_profile

#Install ANT
USER root
RUN mkdir /opt/ant \
    && unzip -q /softwares/apache-ant-1.7.1.zip -d /opt/ant \
    && chown -R docker:docker /opt/ant \
    && chmod -R 755 /opt/ant
USER docker
ENV ANT_HOME /opt/ant/apache-ant-1.7.1
ENV ANT_OPTS "-Xms768m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=768m"
ENV PATH $ANT_HOME/bin:$PATH
RUN echo "export ANT_HOME=/opt/ant/apache-ant-1.7.1" >> /home/docker/.bash_profile \
    && echo "export ANT_OPTS=\"-Xms768m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=768m\"" >> /home/docker/.bash_profile \
    && echo "export PATH=/opt/ant/apache-ant-1.7.1/bin:$PATH" >> /home/docker/.bash_profile \
    && source /home/docker/.bash_profile


#Clean the yum
USER root
RUN yum clean all

#Remove the install sources
RUN rm -rf /softwares/*

#Expose ports
EXPOSE 22 8080 8180 8280 8380 8787 8009

WORKDIR /

CMD ["/usr/sbin/sshd", "-D"]
