FROM debian:jessie
MAINTAINER fzerorubigd <fzero@rubi.gd>

ENV GERRIT_USER gerrit
ENV GERRIT_WAR /home/gerrit/gerrit.war
ENV GERRIT_DATA /home/gerrit/data

RUN apt-get update \
    && apt-get install -y openjdk-7-jre-headless git bash openssh-server wget \
    && useradd -m -r -s /bin/bash ${GERRIT_USER} \
    && mkdir ${GERRIT_DATA}
    && wget https://www.gerritcodereview.com/download/gerrit-2.12.war -O ${GERRIT_WAR} \
    && rm -rf /var/lib/apt/lists/* 
    
ADD docker-initscript.sh  /bin/docker-initscript.sh
CMD chmod a+x /bin/docker-initscript.sh

EXPOSE     8080 29418
VOLUME     ${GERRIT_DATA}
WORKDIR    ${GERRIT_DATA}

ENTRYPOINT ["/bin/docker-initscript.sh"]
CMD        ["gerrit" ]

