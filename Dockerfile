FROM openjdk:8-jre-slim

LABEL maintainer="zsx <thinkernel@gmail.com>"

ENV APACHEDS_VERSION 2.0.0.AM26
ENV APACHEDS_VOLUME   /var/lib/apacheds
ENV APACHEDS_TEMPLATE /var/lib/apacheds-template
ENV APACHEDS_DATA     /var/lib/apacheds-${APACHEDS_VERSION}
ENV APACHEDS_INSTANCE default
ENV APACHEDS_INSTANCE_PATH "${APACHEDS_DATA}/${APACHEDS_INSTANCE}"

RUN set -x \
    && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
       dumb-init \
       procps \
       wget ;\
       rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/apacheds.deb \
       "http://apache.communilink.net//directory/apacheds/dist/${APACHEDS_VERSION}/apacheds-${APACHEDS_VERSION}-amd64.deb" \
    && dpkg -i /tmp/apacheds.deb \
    && rm /tmp/apacheds.deb

# Save the default instance directory to another place as a template for bootstrap.
# Replace the default instance directory with a soft link point to the volume location.
RUN mv "${APACHEDS_DATA}" "${APACHEDS_TEMPLATE}" && \
    mkdir -p "${APACHEDS_VOLUME}" && \
    ln -s "${APACHEDS_VOLUME}" "${APACHEDS_DATA}"
VOLUME "${APACHEDS_VOLUME}"

COPY apacheds-entrypoint.sh /
COPY apacheds-start.sh /
RUN chmod +x /apacheds*.sh
RUN mkdir /docker-entrypoint-init.d

EXPOSE 10389 10636

ENTRYPOINT ["/apacheds-entrypoint.sh"]
CMD ["/apacheds-start.sh"]
