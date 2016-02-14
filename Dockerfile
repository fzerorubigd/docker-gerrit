FROM debian:jessie
MAINTAINER fzerorubigd <fzero@rubi.gd>

ENV GERRIT_USER gerrit
ENV GERRIT_WAR /home/gerrit/gerrit.war
ENV GERRIT_VERSION 2.12

RUN apt-get update \
    && apt-get install -y openjdk-7-jre-headless git bash openssh-server wget \
    && useradd -m -s /bin/bash ${GERRIT_USER} \
    && mkdir -p /home/gerrit/data \
    && chown -R ${GERRIT_USER}:${GERRIT_USER}
    && wget https://www.gerritcodereview.com/download/gerrit-${GERRIT_VERSION}.war -O ${GERRIT_WAR} \
    && rm -rf /var/lib/apt/lists/* 
    
ADD docker-initscript.sh  /bin/docker-initscript.sh
RUN chmod a+x /bin/docker-initscript.sh

EXPOSE     8080 29418
VOLUME     /home/gerrit/data
WORKDIR    /home/gerrit/data

ENTRYPOINT ["/bin/docker-initscript.sh"]
CMD        ["gerrit" ]

