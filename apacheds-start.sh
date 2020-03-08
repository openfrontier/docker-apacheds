#!/usr/bin/env bash
set -e

PIDFILE="${APACHEDS_INSTANCE_PATH}/run/apacheds-default.pid"

echo "Starting up ApacheDS..."
/opt/apacheds-${APACHEDS_VERSION}/bin/apacheds start ${APACHEDS_INSTANCE}
sleep 2  # Wait on new pid

shutdown_apacheds() {
    echo "Shutting down ApacheDS..."
    /opt/apacheds-${APACHEDS_VERSION}/bin/apacheds stop ${APACHEDS_INSTANCE}
}

trap shutdown_apacheds SIGINT SIGTERM EXIT
tail --pid=$(cat $PIDFILE) -f ${APACHEDS_INSTANCE_PATH}/log/wrapper.log
