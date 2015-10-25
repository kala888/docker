#!/bin/sh

#Attach the installation package to container
cd /softwares
unzip -q platformservices_614734339.zip -d /softwares/endeca 
unzip -q mdex_6.4.1.2.763315.zip -d /softwares/endeca
unzip -q cas-3.1.2.1.zip -d /softwares/endeca

chmod -R 777 /softwares
chmod -R 755 /opt

#Begin the install
#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.6.0_34.zip -d /opt/java 
chown -R docker:docker /opt/java
chmod -R 755 /opt/java
ln -s /opt/java/jdk1.6.0_34 /opt/java/jdk


echo "export JAVA_HOME=/opt/java/jdk" >> /home/docker/.bash_profile
echo "export PATH=/opt/java/jdk/bin:$PATH" >> /home/docker/.bash_profile
source /home/docker/.bash_profile


#Install Endeca

mkdir /opt/endeca
chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

#platform services silent install specific env variables
export ENDECA_HTTP_SERVICE_PORT=8888
export ENDECA_HTTP_SERVICE_SHUTDOWN_PORT=8090
export ENDECA_CONTROL_SYSTEM_JCD_PORT=8088
export RUN_EAC_CONTROLLER=Y
export ENDECA_MDEX_INSTALL_DIR=/opt/endeca/MDEX/6.4.1.2
export INSTALL_REF_APPS=Y
#cas silent install specific env variables
export CAS_PORT=8500
export CAS_SHUTDOWN_PORT=8506
export CAS_HOST=localhost
#create silent install text file of platformservice

 echo $ENDECA_HTTP_SERVICE_PORT > /softwares/endeca/platformservices-silent.txt && \
    echo $ENDECA_HTTP_SERVICE_SHUTDOWN_PORT >> /softwares/endeca/platformservices-silent.txt && \
    echo $ENDECA_CONTROL_SYSTEM_JCD_PORT >>  /softwares/endeca/platformservices-silent.txt && \
    echo $RUN_EAC_CONTROLLER >> /softwares/endeca/platformservices-silent.txt && \
    echo $ENDECA_MDEX_INSTALL_DIR >> /softwares/endeca/platformservices-silent.txt && \
    echo $INSTALL_REF_APPS >> /softwares/endeca/platformservices-silent.txt
#create silent install text file of cas
 echo $CAS_PORT > /softwares/endeca/cas-silent.txt && \
    echo $CAS_SHUTDOWN_PORT >> /softwares/endeca/cas-silent.txt && \
    echo $CAS_HOST >> /softwares/endeca/cas-silent.txt
	
#MDEX
su - docker -c "/bin/sh" -c  "/softwares/endeca/mdex_6.4.1.2.763315_x86_64pc-linux.sh --silent --target /opt/"

echo "export ENDECA_MDEX_ROOT=/opt/endeca/MDEX/6.4.1.2" >> /home/docker/.bash_profile
echo "export PATH=/opt/endeca/MDEX/6.4.1.2/bin:$PATH" >> /home/docker/.bash_profile
source /home/docker/.bash_profile

#PlatformService
su - docker -c "/bin/sh" -c  "/softwares/endeca/platformservices_614734339_x86_64pc-linux.sh --silent --target /opt < /softwares/endeca/platformservices-silent.txt"

echo "export ENDECA_ROOT=/opt/endeca/PlatformServices/6.1.4" >> /home/docker/.bash_profile
echo "export PERLLIB=/opt/endeca/PlatformServices/6.1.4/lib/perl:/opt/endeca/PlatformServices/6.1.4/lib/perl/Control:/opt/endeca/PlatformServices/6.1.4/perl/lib:/opt/endeca/PlatformServices/6.1.4/perl/lib/site_perl:$PERLIB" >> /home/docker/.bash_profile
echo "export PERL5LIB=/opt/endeca/PlatformServices/6.1.4/lib/perl:/opt/endeca/PlatformServices/6.1.4/lib/perl/Control:/opt/endeca/PlatformServices/6.1.4/perl/lib:/opt/endeca/PlatformServices/6.1.4/perl/lib/site_perl:$PERL5LIB" >> /home/docker/.bash_profile
echo "export PATH=/opt/endeca/PlatformServices/6.1.4/bin:/opt/endeca/PlatformServices/6.1.4/perl/bin:/opt/endeca/PlatformServices/6.1.4/utilities:$PATH" >> /home/docker/.bash_profile
echo "export ENDECA_CONF=/opt/endeca/PlatformServices/workspace" >> /home/docker/.bash_profile
echo "export PATH=/opt/endeca/PlatformServices/6.1.4/bin:/opt/endeca/PlatformServices/6.1.4/perl/bin:/opt/endeca/PlatformServices/6.1.4/utilities:$PATH" >> /home/docker/.bash_profile
echo "export ENDECA_REFERENCE_DIR=/opt/endeca/PlatformServices/reference" >> /home/docker/.bash_profile
source /home/docker/.bash_profile


#ToolsAndFrameworks
su - docker -c "/bin/sh" -c  "unzip -q /softwares/ToolsAndFrameworks_3.1.2.zip -d /opt/endeca/"

echo "export ENDECA_TOOLS_CONF=/opt/endeca/ToolsAndFrameworks/3.1.2/server/workspace" >> /home/docker/.bash_profile
echo "export ENDECA_TOOLS_ROOT=/opt/endeca/ToolsAndFrameworks/3.1.2" >> /home/docker/.bash_profile
source /home/docker/.bash_profile

#CAS
su - docker -c "/bin/sh" -c  "/softwares/endeca/cas-3.1.2.1-x86_64pc-linux.RC2.sh --silent --target /opt < /softwares/endeca/cas-silent.txt"

#Create the app folder
mkdir /opt/endeca/apps
chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

#change the Endeca user to docker.
sed -i "s/ENDECA_USER=endeca/ENDECA_USER=docker/g" /opt/endeca/ToolsAndFrameworks/3.1.2/server/bin/workbench-init.d.sh

#Remove the install sources
#rm -rf /softwares/*

yum -y install zip && yum -y clean all