#!/bin/sh

#Attach the installation package to container

cd /softwares

#Begin the install
#Install JAVA
mkdir /opt/java
unzip -q /softwares/jdk1.7.0_15.zip -d /opt/java
#chown -R docker:docker /opt/java
chmod -R 755 /opt/java
ln -s /opt/java/jdk1.7.0_15 /opt/java/jdk

echo "export JAVA_HOME=/opt/java/jdk" >> /home/docker/.bash_profile 
echo "export PATH=/opt/java/jdk/bin:$PATH" >> /home/docker/.bash_profile 
#source /home/docker/.bash_profile 


#Install Endeca

mkdir /opt/endeca
#chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

#platform services silent install specific env variables
export ENDECA_HTTP_SERVICE_PORT=8888
export ENDECA_HTTP_SERVICE_SHUTDOWN_PORT=8090
#export ENDECA_CONTROL_SYSTEM_JCD_PORT=8088
export RUN_EAC_CONTROLLER=Y
export ENDECA_MDEX_INSTALL_DIR=/opt/endeca/MDEX/6.5.1
export INSTALL_REF_APPS=Y
#cas silent install specific env variables
export CAS_PORT=8500
export CAS_SHUTDOWN_PORT=8506
export CAS_HOST=localhost
#create silent install text file of platformservice

 echo $ENDECA_HTTP_SERVICE_PORT > /softwares/platformservices-silent.txt && \
    echo $ENDECA_HTTP_SERVICE_SHUTDOWN_PORT >> /softwares/platformservices-silent.txt && \
   # echo $ENDECA_CONTROL_SYSTEM_JCD_PORT >>  /softwares/platformservices-silent.txt && \
    echo $RUN_EAC_CONTROLLER >> /softwares/platformservices-silent.txt && \
    echo $ENDECA_MDEX_INSTALL_DIR >> /softwares/platformservices-silent.txt && \
    echo $INSTALL_REF_APPS >> /softwares/platformservices-silent.txt
#create silent install text file of cas
 echo $CAS_PORT > /softwares/cas-silent.txt && \
    echo $CAS_SHUTDOWN_PORT >> /softwares/cas-silent.txt && \
    echo $CAS_HOST >> /softwares/cas-silent.txt
	
#MDEX
#su - docker -c "/bin/sh" -c  "/softwares/OCmdex6.5.1-Linux64_829811.sh --silent --target /opt/"
/softwares/OCmdex6.5.1-Linux64_829811.sh --silent --target /opt/

echo "export ENDECA_MDEX_ROOT=/opt/endeca/MDEX/6.5.1" >> /home/docker/.bash_profile 
echo "export PATH=/opt/endeca/MDEX/6.5.1/bin:$PATH" >> /home/docker/.bash_profile 
source /home/docker/.bash_profile 

#PlatformService
#su - docker -c "/bin/sh" -c "/softwares/OCplatformservices11.1.0-Linux64.bin --silent --target /opt < /softwares/platformservices-silent.txt"
/softwares/OCplatformservices11.1.0-Linux64.bin --silent --target /opt < /softwares/platformservices-silent.txt

echo "export ENDECA_ROOT=/opt/endeca/PlatformServices/11.1.0" >> /home/docker/.bash_profile 
echo "export PERLLIB=/opt/endeca/PlatformServices/11.1.0/lib/perl:/opt/endeca/PlatformServices/11.1.0/lib/perl/Control:/opt/endeca/PlatformServices/11.1.0/perl/lib:/opt/endeca/PlatformServices/11.1.0/perl/lib/site_perl:$PERLIB" >> /home/docker/.bash_profile 
echo "export PERL5LIB=/opt/endeca/PlatformServices/11.1.0/lib/perl:/opt/endeca/PlatformServices/11.1.0/lib/perl/Control:/opt/endeca/PlatformServices/11.1.0/perl/lib:/opt/endeca/PlatformServices/11.1.0/perl/lib/site_perl:$PERL5LIB" >> /home/docker/.bash_profile 
echo "export PATH=/opt/endeca/PlatformServices/11.1.0/bin:/opt/endeca/PlatformServices/11.1.0/perl/bin:/opt/endeca/PlatformServices/11.1.0/utilities:$PATH" >> /home/docker/.bash_profile 
echo "export ENDECA_CONF=/opt/endeca/PlatformServices/workspace" >> /home/docker/.bash_profile 
echo "export PATH=/opt/endeca/PlatformServices/11.1.0/bin:/opt/endeca/PlatformServices/11.1.0/perl/bin:/opt/endeca/PlatformServices/11.1.0/utilities:$PATH" >> /home/docker/.bash_profile 
echo "export ENDECA_REFERENCE_DIR=/opt/endeca/PlatformServices/reference" >> /home/docker/.bash_profile 
source /home/docker/.bash_profile 


#ToolsAndFrameworks
cp /softwares/cd/Disk1/install/silent_response.rsp /softwares/toolsframeworks-install.txt
#su - docker -c "/bin/sh" -c  "/softwares/cd/Disk1/install/silent_install.sh /softwares/toolsframeworks-install.txt ToolsAndFrameworks /opt/endeca/ToolsAndFrameworks admin"
/softwares/cd/Disk1/install/silent_install.sh /softwares/toolsframeworks-install.txt ToolsAndFrameworks /opt/endeca/ToolsAndFrameworks admin

echo "export ENDECA_TOOLS_CONF=/opt/endeca/ToolsAndFrameworks/11.1.0/server/workspace" >> /home/docker/.bash_profile 
echo "export ENDECA_TOOLS_ROOT=/opt/endeca/ToolsAndFrameworks/11.1.0" >> /home/docker/.bash_profile 
source /home/docker/.bash_profile 

#CAS
#su - docker -c "/bin/sh" -c "/softwares/OCcas11.1.0-Linux64.sh --silent --target /opt < /softwares/cas-silent.txt"
/softwares/OCcas11.1.0-Linux64.sh --silent --target /opt < /softwares/cas-silent.txt

#Create the app folder
mkdir /opt/endeca/apps
#chown -R docker:docker /opt/endeca
chmod -R 755 /opt/endeca

# Runtime env
echo "export ENDECA_CONF=/opt/endeca/PlatformServices/workspace" >>  /home/docker/.bash_profile
echo "source /opt/endeca/PlatformServices/11.1.0/setup/installer_sh.ini" >> /home/docker/.bash_profile
echo "source /opt/endeca/MDEX/6.5.1/mdex_setup_sh.ini" >> /home/docker/.bash_profile

#change the Endeca user to docker.
sed -i "s/ENDECA_USER=endeca/ENDECA_USER=docker/g" /opt/endeca/ToolsAndFrameworks/11.1.0/server/bin/workbench-init.d.sh

#Remove the install sources
#rm -rf /softwares/*
