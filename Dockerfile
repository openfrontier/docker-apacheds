FROM openjdk:8-jre-buster

LABEL maintainer="zsx <thinkernel@gmail.com>"

ENV APACHEDS_VERSION 2.0.0.AM26
ENV APACHEDS_DATA /var/lib/apacheds-${APACHEDS_VERSION}

RUN set -x \
    && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
       procps ;\
       rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/apacheds.deb \
       "http://apache.communilink.net//directory/apacheds/dist/${APACHEDS_VERSION}/apacheds-${APACHEDS_VERSION}-amd64.deb" \
    && dpkg -i /tmp/apacheds.deb \
    && rm /tmp/apacheds.deb

# Ensure the entrypoint scripts are in a fixed location
#COPY apacheds-entrypoint.sh /
COPY apacheds-start.sh /
RUN chmod +x /apacheds*.sh

RUN mv /etc/init.d/apacheds-${APACHEDS_VERSION}-default /etc/init.d/apacheds

#RUN service apacheds restart

EXPOSE 10389 10636

CMD ["/apacheds-start.sh"]
