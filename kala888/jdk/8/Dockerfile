FROM kala888/centos7
MAINTAINER ${maintainer:-kala88s8}
ENV DOWNLOAD_SERVER ${downloadServer:-http://172.17.3.91}

RUN echo $DOWNLOAD_SERVER

ADD ./install.sh /install.sh
RUN chmod +x /install.sh && sh /install.sh

ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH
