#!/bin/bash
set -euo pipefail

rm -rf /buil/gerrit/plugins/gerrit-oauth-provider


if [ ! -d "/build/gerrit/.git" ]; then
    git clone https://gerrit.googlesource.com/gerrit /build/gerrit
else
    cd /build/gerrit && git pull
fi;

cd /build/gerrit && git checkout stable-${GERRIT_VERSION}

if [ ! -d "/build/buck/.git" ]; then
    git clone https://github.com/facebook/buck  /build/buck
else
    cd /build/buck && git pull
fi;

cd /build/buck && git checkout $(cat ../gerrit/.buckversion)

ant
mkdir /build/bin
export PATH=/build/bin:$PATH

ln -s `pwd`/bin/buck /build/bin/
ln -s `pwd`/bin/buckd /build/bin/

cd /build/gerrit 
buck build gerrit


git clone --recursive https://gerrit.googlesource.com/plugins/gitiles /build/gerrit/plugins/gitiles
cd /build/gerrit/plugins/gitiles && git checkout stable-${GERRIT_VERSION}
git clone --recursive https://github.com/davido/gerrit-oauth-provider.git /build/gerrit/plugins/gerrit-oauth-provider
git clone --recursive https://gerrit.googlesource.com/plugins/avatars-gravatar /build/gerrit/plugins/avatars-gravatar
git clone --recursive https://gerrit.googlesource.com/plugins/plugin-manager /build/gerrit/plugins/plugin-manager
git clone --recursive https://gerrit.googlesource.com/plugins/delete-project /build/gerrit/plugins/delete-project
git clone --recursive https://gerrit.googlesource.com/plugins/admin-console  /build/gerrit/plugins/admin-console
git clone --recursive https://gerrit.googlesource.com/plugins/branch-network /build/gerrit/plugins/branch-network

rm -rf /build/gerrit/plugins/commit-message-length-validator/
git clone https://gerrit.googlesource.com/plugins/commit-message-length-validator /build/gerrit/plugins/commit-message-length-validator/
cd /build/gerrit/plugins/commit-message-length-validator/ && git checkout stable-${GERRIT_VERSION}

rm -rf /build/gerrit/plugins/replication/
gt clone https://gerrit.googlesource.com/plugins/replication /build/gerrit/plugins/replication/
cd /build/gerrit/plugins/replication/ && git checkout stable-${GERRIT_VERSION}

rm -rf /build/gerrit/plugins/download-commands 
git clone https://gerrit.googlesource.com/plugins/download-commands /build/gerrit/plugins/download-commands 
cd /build/gerrit/plugins/download-commands  && git checkout stable-${GERRIT_VERSION}

rm -rf /build/gerrit/plugins/reviewnotes
git clone https://gerrit.googlesource.com/plugins/reviewnotes /build/gerrit/plugins/reviewnotes
cd /build/gerrit/plugins/reviewnotes && git checkout v${GERRIT_VERSION}

rm -rf /build/gerrit/plugins/singleusergroup
git clone https://gerrit.googlesource.com/plugins/singleusergroup /build/gerrit/plugins/singleusergroup
cd /build/gerrit/plugins/singleusergroup && git checkout v${GERRIT_VERSION}


cd /build/gerrit
buck build plugins/singleusergroup:singleusergroup
buck build plugins/reviewnotes:reviewnotes
buck build plugins/commit-message-length-validator:commit-message-length-validator
buck build plugins/replication:replication
buck build plugins/download-commands:download-commands
buck build plugins/gitiles:gitiles
buck build plugins/gerrit-oauth-provider:gerrit-oauth-provider
buck build plugins/avatars-gravatar:avatars-gravatar
buck build plugins/plugin-manager:plugin-manager
buck build plugins/delete-project:delete-project
buck build plugins/admin-console:admin-console
buck build plugins/branch-network:branch-network

buck build plugins:core

