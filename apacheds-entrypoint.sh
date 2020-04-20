#!/usr/bin/env bash
set -e

if [ "$1" = "/apacheds-start.sh" ]; then
  if [ ! -e "${APACHEDS_INSTANCE_PATH}" ]; then
    echo "The ${APACHEDS_INSTANCE} instance doesn't exist. Creating instance ..."
    cp -rp "${APACHEDS_TEMPLATE}/default" "${APACHEDS_INSTANCE_PATH}"
    # Add customise ldif files
    if [ -e "${APACHEDS_INSTANCE_PATH}/conf/config.ldif" ]; then
      for f in /docker-entrypoint-init.d/*; do
        case "$f" in
          *.ldif)    echo "$0: importing $f"; echo >> "${APACHEDS_INSTANCE_PATH}/conf/config.ldif" ; cat "$f" >> "${APACHEDS_INSTANCE_PATH}/conf/config.ldif" ;;
          *)         echo "$0: ignoring $f" ;;
        esac
      done
      chown apacheds:apacheds "${APACHEDS_INSTANCE_PATH}/conf/config.ldif"
    fi
  else
    echo "Use exists ${APACHEDS_INSTANCE} instance"
  fi
fi
exec "$@"
