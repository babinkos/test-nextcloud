FROM jwilder/nginx-proxy:alpine
LABEL maintainer="babinkos 37809416+babinkos@users.noreply.github.com"
COPY *.sh /
ENV DOCKER_GEN_FORK "github.com/babinkos/docker-gen"
ENV DOCKER_GEN_VERSION "0.7.5-5"
ENV DG_DIST "docker-gen-alpine-linux-musl-amd64"
RUN \
  set -ex; \
  echo "http://alpine.gliderlabs.com/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main" > /etc/apk/repositories; \
#  apk -U --no-cache add file bash ; \
 echo "Downloading: https://$DOCKER_GEN_FORK/releases/download/$DOCKER_GEN_VERSION/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 wget --quiet -O "/tmp/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz" "https://$DOCKER_GEN_FORK/releases/download/$DOCKER_GEN_VERSION/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 ls -l "/tmp/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 tar -C /usr/local/bin -xvzf "/tmp/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 rm "/tmp/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 chown root:root /usr/local/bin/docker-gen; \
 ls -l /usr/local/bin/docker-gen; \
 chmod +x /*.sh
HEALTHCHECK --interval=10s --timeout=3s --start-period=15s \
        CMD \
        /test-https.sh || exit 1
