#!/bin/sh
set -euo pipefail

if [ "$1" = 'gerrit' ]; then
    # Run init on the data directory
    java -jar ${GERRIT_WAR} init --batch -d ${GERRIT_DATA}
    # supervise gerrit 
    /bin/bash ${GERRIT_DATA}/bin/bin/gerrit.sh supervise
else
    exec "$@"
fi;
