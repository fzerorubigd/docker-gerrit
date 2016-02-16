#!/bin/bash
set -euo pipefail

if [ "$1" = 'gerrit' ]; then
    # Run init on the data directory
    # Copy all plugins for the first time
    if [ -e "/home/gerrit/data/plugins/.plugins-${GERRIT_VERSION}" ]; then
        cp /home/gerrit/plugins/* /home/gerrit/data/plugins/
        touch /home/gerrit/data/plugins/.plugins-${GERRIT_VERSION}
    fi;
    java -jar ${GERRIT_WAR} init --batch --no-auto-start -d /home/gerrit/data
   
    # supervise gerrit 
    /bin/bash /home/gerrit/data/bin/gerrit.sh supervise
else
    exec "$@"
fi;
