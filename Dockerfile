FROM debian:jessie
MAINTAINER fzerorubigd <fzero@rubi.gd>

ENV GERRIT_USER gerrit
ENV GERRIT_WAR /home/gerrit/gerrit.war
ENV GERRIT_VERSION 2.12

RUN apt-get update \
    && apt-get install -y openjdk-7-jre-headless git bash openssh-server wget cgit gitweb \
    && useradd -m -s /bin/bash ${GERRIT_USER} \
    && mkdir -p /home/gerrit/data \
    && chown -R ${GERRIT_USER}:${GERRIT_USER} /home/gerrit/data \
    && rm -rf /var/lib/apt/lists/* 

ADD tmp/docker-build/gerrit.war ${GERRIT_WAR}
ADD tmp/docker-build/plugins /home/gerrit/plugins

ADD docker-initscript.sh  /bin/docker-initscript.sh
RUN chmod a+x /bin/docker-initscript.sh

EXPOSE     8080 29418
VOLUME     /home/gerrit/data
WORKDIR    /home/gerrit/data

ENTRYPOINT ["/bin/docker-initscript.sh"]
CMD        ["gerrit" ]

