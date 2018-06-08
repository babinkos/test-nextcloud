FROM nginx-proxy:alpine
LABEL maintainer="babinkos 37809416+babinkos@users.noreply.github.com"
ENV DOCKER_GEN_FORK "github.com/babinkos/docker-gen"
ENV DOCKER_GEN_VERSION 0.7.5
ENV DG_DIST docker-gen-alpine-linux-amd64
RUN \
 wget --quiet "https://$DOCKER_GEN_FORK/releases/download/$DOCKER_GEN_VERSION/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz" \
 && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
