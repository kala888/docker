FROM pgbi/kong-dashboard

# add ContainerPilot configuration
RUN apk --update add curl &&\
    rm -rf /var/cache/apk/*


# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 2.4.1
RUN export CP_SHA1=198d96c8d7bfafb1ab6df96653c29701510b833c \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

# ADD https://raw.githubusercontent.com/kala888/docker/master/softwares/consul_client.tar.gz /bin/
COPY containerpilot.json /etc/containerpilot.json
ENV CONTAINERPILOT=file:///etc/containerpilot.json

EXPOSE 8080
