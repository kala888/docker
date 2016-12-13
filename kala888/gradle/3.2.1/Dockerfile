FROM kala888/jdk:8
MAINTAINER ${maintainer:-kala888}
ENV DOWNLOAD_SERVER ${downloadServer:-http://172.17.3.91}

ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && sh /install.sh

ENV GRADLE_HOME /opt/gradle
ENV PATH $GRADLE_HOME/bin:$PATH
