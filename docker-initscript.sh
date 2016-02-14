#!/bin/bash
set -euo pipefail

if [ "$1" = 'gerrit' ]; then
    # Run init on the data directory
    java -jar ${GERRIT_WAR} init --batch --no-auto-start -d /home/gerrit/data
    # supervise gerrit 
    /bin/bash /home/gerrit/data/bin/gerrit.sh supervise
else
    exec "$@"
fi;
