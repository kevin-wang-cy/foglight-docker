# docker build -t docker-release-local.artifactory.labs.quest.com/foglight:5.9.5 .
# docker build --build-arg FOGLIGHT_INSTALLER_UUID=<uuid> -t docker-release-local.artifactory.labs.quest.com/foglight:5.9.5 .
# 
#       docker run -d --name foglight595 -p 8080:8080 -p 65000:65000 docker-release-local.artifactory.labs.quest.com/foglight:5.9.5
#
#       docker exec -u root/foglight -it foglight595 bash
#
#   docker login docker-release-local.artifactory.labs.quest.com -u kevin.wang@quest.com 
#   docker pull/push docker-release-local.artifactory.labs.quest.com/foglight:5.9.5
FROM kevinwangcy/basebuildbox:latest
MAINTAINER Kevin C.Y. Wang <kevin.wang.cy@gmail.com>

# Install Foglight
ARG FOGLIGHT_INSTALLER_UUID=1e37ddac-85fa-4bdc-8cd1-09fef526a667
ARG FOGLIGHT_INSTALLER_FILE=Foglight-5_9_5-install_linux-x86_64.bin
ARG FOGLIGHT_INSTALLER_URL=http://azrepos.im.labs.qsft/rmbundles/$FOGLIGHT_INSTALLER_UUID/installers/linux-x86_64/$FOGLIGHT_INSTALLER_FILE
ARG FOGLIGHT_SLIENT_FILE=fms_silent_install.properties
ARG FOGLIGHT_SLIENT_URL=http://azrepos.im.labs.qsft/rmbundles/$FOGLIGHT_INSTALLER_UUID/docs/$FOGLIGHT_SLIENT_FILE

ADD . /tmp/fms
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ttf-dejavu && \
    chmod +x /tmp/fms/prepare.sh && \
    chmod +x /tmp/fms/foglight.runit.sh && \
    sh /tmp/fms/prepare.sh && \
    mkdir /etc/service/foglight && \
    cp /tmp/fms/foglight.runit.sh /etc/service/foglight/run && \
    chown -R foglight:foglight /tmp && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER foglight
RUN curl -L -o /tmp/$FOGLIGHT_INSTALLER_FILE $FOGLIGHT_INSTALLER_URL && \
    curl -L -o /tmp/$FOGLIGHT_SLIENT_FILE $FOGLIGHT_SLIENT_URL && \
    sed 's/[#]USER_INSTALL_DIR=.*/USER_INSTALL_DIR=\/home\/foglight\/fms/g' /tmp/$FOGLIGHT_SLIENT_FILE > /tmp/new_$FOGLIGHT_SLIENT_FILE && \
    cd /tmp && \
    ls -al && \
    chmod -R +rwx /tmp && \
    ls -al && \
    ./$FOGLIGHT_INSTALLER_FILE -i silent -f /tmp/new_${FOGLIGHT_SLIENT_FILE} && \
    ls -alF /home/foglight/fms && \
    rm -rf /tmp/* /var/tmp/*

USER root
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

EXPOSE 8080/tcp 65000/tcp

