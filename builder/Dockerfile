FROM java:latest
MAINTAINER fzerorubigd <fzero@rubi.gd>

ENV GERRIT_VERSION 2.12

RUN apt-get update \
    && apt-get install -y  ant git bash wget curl build-essential zip \
    && mkdir /build

ADD docker-initscript.sh  /bin/docker-initscript.sh
RUN chmod a+x /bin/docker-initscript.sh

VOLUME     /build/
WORKDIR    /build/

ENTRYPOINT ["/bin/docker-initscript.sh"]
CMD        ["build" ]

