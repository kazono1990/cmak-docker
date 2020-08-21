FROM openjdk:11

ENV CMAK_VERSION=3.0.0.5
ENV ZK_HOSTS="zk001.nezumi.stream.kks.ynwm.yahoo.co.jp:2181,zk002.nezumi.stream.kks.ynwm.yahoo.co.jp:2181,zk003.nezumi.stream.kks.ynwm.yahoo.co.jp:2181"

RUN wget "https://github.com/yahoo/CMAK/archive/${CMAK_VERSION}.tar.gz" \
    && tar -xzf ${CMAK_VERSION}.tar.gz \
    && cd /CMAK-${CMAK_VERSION}/ \
    && ./sbt clean dist \
    && unzip -d ./builded ./target/universal/cmak-${CMAK_VERSION}.zip \
    && mv -T ./builded/cmak-${CMAK_VERSION} /opt/cmak

WORKDIR /opt/cmak

COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

EXPOSE 9001
ENTRYPOINT ["./entrypoint.sh"]
