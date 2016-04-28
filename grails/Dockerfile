FROM java:8
MAINTAINER Kala Liu (email:kala.niubility@gmail.com)
ENV REFRESHED_AT 4/28/2016 11:12

# Set customizable env vars defaults.
# Set Grails version (default: 3.1.1; min: 3.0.0; max: 3.1.1).
ENV GRAILS_VERSION 3.1.4

# Install Grails
WORKDIR /opt/
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip && \
    ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /opt/grails
ENV PATH $GRAILS_HOME/bin:$PATH

# Setup grails profiles
RUN wget https://codeload.github.com/grails/grails-profile-repository/zip/master && \
    unzip master && \
    mv grails-profile-repository-master/profiles/ $GRAILS_HOME && \
    rm -rf master && \
    rm -rf grails-profile-repository-master


# Create App Directory
RUN mkdir /app

# Set Workdir
WORKDIR /app

# Set Default Behavior
ENTRYPOINT ["grails"]