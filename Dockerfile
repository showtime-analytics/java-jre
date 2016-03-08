FROM docker.io/alpine:3.3
MAINTAINER Alberto Gregoris <alberto@showtimeanalytics.com>

#Set environment
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=51 \
    JAVA_VERSION_BUILD=16 \
    JAVA_PACKAGE=jre
ENV JAVA_HOME /opt/${JAVA_PACKAGE} 
ENV PATH=${PATH}:${JAVA_HOME}/bin

# Download and unarchive Java
RUN cd /tmp \
  && curl -sS -k "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" -o glibc-2.21-r2.apk \
  && curl -sS -k "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" -o glibc-bin-2.21-r2.apk \
  && apk update && apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk \
  && /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib \
  && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
  && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  | gunzip -c - | tar -xf - -C /opt \
  && ln -s /opt/${JAVA_PACKAGE}1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} \
  && rm -rf ${JAVA_HOME}/*src.zip \
           ${JAVA_HOME}/THIRDPARTYLICENSEREADME* \
           ${JAVA_HOME}/lib/missioncontrol \
           ${JAVA_HOME}/lib/visualvm \
           ${JAVA_HOME}/lib/*javafx* \
           ${JAVA_HOME}/lib/plugin.jar \
           ${JAVA_HOME}/lib/ext/jfxrt.jar \
           ${JAVA_HOME}/bin/javaws \
           ${JAVA_HOME}/lib/javaws.jar \
           ${JAVA_HOME}/lib/desktop \
           ${JAVA_HOME}/plugin \
           ${JAVA_HOME}/lib/deploy* \
           ${JAVA_HOME}/lib/*javafx* \
           ${JAVA_HOME}/lib/*jfx* \
           ${JAVA_HOME}/lib/amd64/libdecora_sse.so \
           ${JAVA_HOME}/lib/amd64/libprism_*.so \
           ${JAVA_HOME}/lib/amd64/libfxplugins.so \
           ${JAVA_HOME}/lib/amd64/libglass.so \
           ${JAVA_HOME}/lib/amd64/libgstreamer-lite.so \
           ${JAVA_HOME}/lib/amd64/libjavafx*.so \
           ${JAVA_HOME}/lib/amd64/libjfx*.so \
           /var/cache/apk/* \
           /tmp/* 
