FROM openjdk:8-jre-buster

LABEL maintainer="zsx <thinkernel@gmail.com>"

ENV APACHEDS_VERSION 2.0.0.AM26
ENV APACHEDS_DATA /var/lib/apacheds-${APACHEDS_VERSION}
ENV APACHEDS_INSTANCE default
ENV APACHEDS_INSTANCE_PATH="${APACHEDS_DATA}/${APACHEDS_INSTANCE}"

RUN set -x \
    && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
       procps ;\
       rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/apacheds.deb \
       "http://apache.communilink.net//directory/apacheds/dist/${APACHEDS_VERSION}/apacheds-${APACHEDS_VERSION}-amd64.deb" \
    && dpkg -i /tmp/apacheds.deb \
    && rm /tmp/apacheds.deb

# Create a instance volume
RUN mv ${APACHEDS_DATA} /var/lib/apacheds && \
    mkdir -p ${APACHEDS_DATA} && \
    chown apacheds:apacheds ${APACHEDS_DATA}
VOLUME ${APACHEDS_DATA}

COPY apacheds-entrypoint.sh /
COPY apacheds-start.sh /
RUN chmod +x /apacheds*.sh

EXPOSE 10389 10636

ENTRYPOINT ["/apacheds-entrypoint.sh"]
CMD ["/apacheds-start.sh"]
