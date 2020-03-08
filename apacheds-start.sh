#!/usr/bin/env sh
set -e

APACHEDS_INSTANCE_PATH="${APACHEDS_DATA}/default"
PIDFILE="${APACHEDS_INSTANCE_PATH}/run/apacheds-default.pid"

echo "Starting up ApacheDS..."
/opt/apacheds-${APACHEDS_VERSION}/bin/apacheds start default
sleep 2  # Wait on new pid

shutdown(){
    echo "Shutting down ApacheDS..."
    /opt/apacheds-${APACHEDS_VERSION}/bin/apacheds stop default
}

trap shutdown INT TERM
tail -n 0 --pid=$(cat $PIDFILE) -f ${APACHEDS_INSTANCE_PATH}/log/apacheds.log
