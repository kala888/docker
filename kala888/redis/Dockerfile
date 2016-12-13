FROM kala888/centos7

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r redis && useradd -r -g redis redis

ENV REDIS_VERSION 3.2.0
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.0.tar.gz
ENV REDIS_DOWNLOAD_SHA1 0c1820931094369c8cc19fc1be62f598bc5961ca

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make' \
	&& set -x \
	&& yum update && yum install -y $buildDeps  \
	&& wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -rf /usr/src/redis

RUN mkdir /data
#RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

#COPY docker-entrypoint.sh /usr/local/bin/
#RUN chmod 777 /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server" ]
