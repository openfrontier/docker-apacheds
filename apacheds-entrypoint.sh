#!/usr/bin/env bash
set -e

if [ "$1" = "/apacheds-start.sh" ]; then
  if [ ! -e "${APACHEDS_INSTANCE_PATH}" ]; then
    echo "The ${APACHEDS_INSTANCE} instance doesn't exist. Creating instance ..."
    cp -rp "${APACHEDS_TEMPLATE}/default" "${APACHEDS_INSTANCE_PATH}"
  else
    echo "Use exists ${APACHEDS_INSTANCE} instance"
  fi
fi
exec "$@"
